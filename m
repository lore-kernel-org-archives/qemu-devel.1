Received: from eggs.gnu.org ([2001:4830:134:3::10]:51133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3mEm-0001pA-2t
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 12:25:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3mEi-0005tV-W7
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 12:25:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d3mEi-0005rg-P4
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 12:25:44 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <cover.1493191677.git.maozy.fnst@cn.fujitsu.com>
Date: Thu, 27 Apr 2017 18:25:28 +0200
In-Reply-To: <cover.1493191677.git.maozy.fnst@cn.fujitsu.com> (Mao Zhongyi's
	message of "Wed, 26 Apr 2017 16:04:14 +0800")
Message-ID: <87o9vhu8av.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 0/4] Convert non-blocking connect and
 fix its error reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, jasowang@redhat.com, kraxel@redhat.com

Mao Zhongyi <maozy.fnst@cn.fujitsu.com> writes:

> v2:
> * PATCH 02 reworking of patch 2 following Markus's suggestion that convert error_report()
>   in the function called by net_socket_*_init() to Error. Also add many error handling
>   information.
> * PATCH 03 net_socket_mcast_create(), net_socket_fd_init_dgram() and net_socket_fd_init() 
>   use the function such as fprintf, perror to report an error message. Convert it to Error.
> * PATCH 04 parse_host_port() may fail without reporting an error. Now, fix it to set an
>   error when it fails.

Needs a bit more work.  I'll continue review with v3.
