Received: from eggs.gnu.org ([2001:4830:134:3::10]:49871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ethj3-0004Wr-Ha
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 17:39:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ethiz-0000Y0-K5
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 17:39:57 -0500
Date: Wed, 7 Mar 2018 23:39:49 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180307223949.5swn6dhu3bx5e3n5@var.youpi.perso.aquilenet.fr>
References: <20180201093545.33741-1-aik@ozlabs.ru>
	<38e2df74-c7d7-a062-8385-494adae0ef89@ozlabs.ru>
	<727e34b6-0f7f-bd0c-9a34-51d5bc844c73@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <727e34b6-0f7f-bd0c-9a34-51d5bc844c73@redhat.com>
Subject: Re: [Qemu-devel] [PATCH qemu] slirp/debug: Print IP addresses in
 human readable form
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Hello,

Remember to Cc the maintainer, I just can't read qemu-devel fully to
find slirp mails.

Thomas Huth, on mer. 07 mars 2018 07:24:16 +0100, wrote:
> >> diff --git a/slirp/arp_table.c b/slirp/arp_table.c
> >> index 3547043..bac608f 100644
> >> --- a/slirp/arp_table.c
> >> +++ b/slirp/arp_table.c
> >> @@ -33,7 +33,7 @@ void arp_table_add(Slirp *slirp, uint32_t ip_addr, uint8_t ethaddr[ETH_ALEN])
> >>      int i;
> >>  
> >>      DEBUG_CALL("arp_table_add");
> >> -    DEBUG_ARG("ip = 0x%x", ip_addr);
> >> +    DEBUG_ARG("ip = %s", inet_ntoa(*(struct in_addr *)&ip_addr));

I never like casts :)
And it happens that the standard doesn't say that s_addr is necessarily
the first field of struct in_addr, so better really initialize a struct
in_addr variable and use that (ditto for arp_table_search and
tcp_listen).

Samuel
