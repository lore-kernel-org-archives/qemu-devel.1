Received: from eggs.gnu.org ([2001:4830:134:3::10]:54557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdFVX-0000HN-6i
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 07:13:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cdFVW-0003Qx-1U
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 07:13:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cdFVV-0003QZ-S1
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 07:13:25 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20161027153217.16984-8-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Thu, 27 Oct 2016 16:32:16 +0100")
References: <20161027153217.16984-1-dgilbert@redhat.com>
	<20161027153217.16984-8-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 13 Feb 2017 13:13:16 +0100
Message-ID: <87tw7y5lwj.fsf@emacs.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 7/8] slirp: VMStatify socket level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com, duanj@linux.vnet.ibm.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Working up the stack, this replaces the slirp_socket_load/save
> with VMState definitions.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


> diff --git a/slirp/socket.h b/slirp/socket.h
> index 8feed2a..0137928 100644
> --- a/slirp/socket.h
> +++ b/slirp/socket.h
> @@ -30,7 +30,7 @@ struct socket {
>  				    * PING reply's */
>    struct tcpiphdr *so_ti;	   /* Pointer to the original ti within
>  				    * so_mconn, for non-blocking connections */
> -  int so_urgc;
> +  uint32_t      so_urgc;
>    union {   /* foreign host */
>        struct sockaddr_storage ss;
>        struct sockaddr_in sin;
> @@ -56,8 +56,8 @@ struct socket {
>    uint8_t	so_iptos;	/* Type of service */
>    uint8_t	so_emu;		/* Is the socket emulated? */
>  
> -  u_char	so_type;		/* Type of socket, UDP or TCP */
> -  int	so_state;		/* internal state flags SS_*, below */
> +  uint8_t       so_type;        /* Type of socket, UDP or TCP */
> +  int32_t       so_state;       /* internal state flags SS_*, below */
>  
>    struct 	tcpcb *so_tcpcb;	/* pointer to TCP protocol control block */
>    u_int	so_expire;		/* When the socket will expire */

I normally preffer to fix types in a previous patch, but that is clearly
a question of taste.

Later, Juan.
