Received: from eggs.gnu.org ([2001:4830:134:3::10]:48851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fzeX6-0008H7-Gx
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 05:00:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fzeX0-00074Q-M3
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 05:00:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50862 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fzeX0-00073g-Cz
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 05:00:22 -0400
Date: Tue, 11 Sep 2018 11:00:18 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180911090018.yjcnv45hyls2cqyc@sirius.home.kraxel.org>
References: <20180906054340.28988-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906054340.28988-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/4] tests: VM build in OpenBSD 6.3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>, Brad Smith <brad@comstyle.com>, Eric Blake <eblake@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>

On Thu, Sep 06, 2018 at 01:43:36PM +0800, Fam Zheng wrote:
> In this new version:
> 
>     - Include the virtio fix by Paolo so that it's easier to test this series.
>     - Improve the slirp patch on input validation and buffer overflow. [Thomas]
>     - Use OpenBSD 6.3 image; Use guestfwd and tftp-server-name.
> 
> Thanks to the loose dependency, the three parts (patch 1; patches 2+3; patch 4)
> can go to individual maintainers if desired.
> 
> Fam Zheng (3):
>   slirp: Add sanity check for str option length
>   slirp: Implement RFC2132 TFTP server name
>   tests: vm: auto_install OpenBSD
> 
> Paolo Bonzini (1):
>   virtio: update MemoryRegionCaches when guest negotiates features

Tested-by: Gerd Hoffmann <kraxel@redhat.com>
