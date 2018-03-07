Received: from eggs.gnu.org ([2001:4830:134:3::10]:35478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etayP-0002Kk-40
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:27:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1etayL-0006vg-4y
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:27:21 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45356 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1etayL-0006uv-02
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 10:27:17 -0500
References: <152028663128.1380.17987632604741265358@bdbb90650ae5>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0402f068-3a13-ca89-f9b0-d96a5a547645@redhat.com>
Date: Wed, 7 Mar 2018 16:26:56 +0100
MIME-Version: 1.0
In-Reply-To: <152028663128.1380.17987632604741265358@bdbb90650ae5>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 00/22] remove i386/pc dependency:
 generic SuperIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, f4bug@amsat.org
Cc: famz@redhat.com, mst@redhat.com, hpoussin@reactos.org, marcel@redhat.com, aurelien@aurel32.net, mark.cave-ayland@ilande.co.uk, aik@ozlabs.ru, thuth@redhat.com, ehabkost@redhat.com, gxt@mprc.pku.edu.cn, yongbok.kim@mips.com, atar4qemu@gmail.com, rth@twiddle.net

On 05/03/2018 22:50, no-reply@patchew.org wrote:
>   CC      hw/misc/applesmc.o
>   CC      hw/misc/max111x.o
> /tmp/qemu-test/src/hw/isa/isa-superio.c: In function 'isa_superio_realize':
> /tmp/qemu-test/src/hw/isa/isa-superio.c:39:46: error: format '%ld' expects argument of type 'long int', but argument 2 has type 'long long unsigned int' [-Werror=format=]
>              warn_report("superio: ignoring %ld parallel controllers",
>                                             ~~^
>                                             %lld
> /tmp/qemu-test/src/hw/isa/isa-superio.c:77:46: error: format '%ld' expects argument of type 'long int', but argument 2 has type 'long long unsigned int' [-Werror=format=]
>              warn_report("superio: ignoring %ld serial controllers",
>                                             ~~^
>                                             %lld

Easily fixed. :)

Paolo
