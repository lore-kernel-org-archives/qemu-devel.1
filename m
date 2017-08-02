Received: from eggs.gnu.org ([2001:4830:134:3::10]:35335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dcure-0006Rx-Ks
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 10:43:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dcurb-0007Py-Fz
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 10:43:10 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:57817)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1dcurb-0006nC-2S
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 10:43:07 -0400
Date: Wed, 2 Aug 2017 16:42:29 +0200
From: Alberto Garcia <berto@igalia.com>
Message-ID: <20170802144229.GA5821@igalia.com>
References: <20170713190116.21608-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170713190116.21608-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] vl.c/exit: pause cpus before closing block
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, jsnow@redhat.com

On Thu, Jul 13, 2017 at 08:01:16PM +0100, Dr. David Alan Gilbert (git) wrote:
> --- a/vl.c
> +++ b/vl.c
> @@ -4787,8 +4787,8 @@ int main(int argc, char **argv, char **envp)
>      replay_disable_events();
>      iothread_stop_all();
>  
> -    bdrv_close_all();
>      pause_all_vcpus();
> +    bdrv_close_all();
>      res_free();

I haven't debugged it yet, but in my computer iotest 093 stops working
(it never finishes) after this change.

Berto
