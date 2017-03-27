Received: from eggs.gnu.org ([2001:4830:134:3::10]:34096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1csWC5-0005Tt-VW
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1csWC2-00044m-Qz
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:04:30 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:64895)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1csWC2-00040b-H7
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:04:26 -0400
Date: Mon, 27 Mar 2017 17:04:23 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170327150423.2olzneh2mf6fho2m@var.youpi.perso.aquilenet.fr>
References: <20170326184634.25042-1-samuel.thibault@ens-lyon.org>
	<20170326184634.25042-3-samuel.thibault@ens-lyon.org>
	<a81b0761-eda4-144d-edfe-f283ecfa6bb6@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a81b0761-eda4-144d-edfe-f283ecfa6bb6@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 2/2] slirp: Send RDNSS in RA only if host
 has an IPv6 DNS server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, jan.kiszka@siemens.com

Hello,

Philippe Mathieu-Daudé, on lun. 27 mars 2017 11:56:00 -0300, wrote:
> Why don't declare at function begining and remove this { } ?

Oh, right, now I can.  While working on the code I still had ifdef
WIN32, so it'd lead to an unused variable warning.  But now that the
ifdef is gone, we can just put the variable at the beginning of the
function indeed.

Thanks,
Samuel
