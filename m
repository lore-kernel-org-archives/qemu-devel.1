Received: from eggs.gnu.org ([2001:4830:134:3::10]:51332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cbzV7-0007ki-1O
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 19:55:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cbzV3-0006O2-Qb
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 19:55:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cbzV3-0006NR-IC
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 19:55:45 -0500
References: <cover.1486285434.git.ben@skyportsystems.com>
	<9a2d2cb01e42d6e61c6198356781dbb2919aca05.1486285434.git.ben@skyportsystems.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <b471e6fa-2381-8f11-3c35-adceb8b8ca15@redhat.com>
Date: Fri, 10 Feb 2017 01:55:41 +0100
MIME-Version: 1.0
In-Reply-To: <9a2d2cb01e42d6e61c6198356781dbb2919aca05.1486285434.git.ben@skyportsystems.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 03/10] docs: VM Generation ID device
 description
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ben@skyportsystems.com, qemu-devel@nongnu.org
Cc: Gal Hammer <ghammer@redhat.com>, imammedo@redhat.com, mst@redhat.com

On 02/05/17 10:11, ben@skyportsystems.com wrote:

> +Or to change guid in runtime use:
> +
> + set-vm-generation-id guid=124e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87
> + set-vm-generation-id guid=auto
> 

Please drop the "guid=" prefix from the examples; the HMP command
doesn't need it / chokes on it. It only takes "auto" or a UUID.

Thanks
Laszlo
