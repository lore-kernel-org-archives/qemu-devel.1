Received: from eggs.gnu.org ([209.51.188.92]:53776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gpKbq-0007Am-Sz
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 17:14:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gpKbq-00035H-58
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 17:14:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gpKbp-00034o-Ts
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 17:14:58 -0500
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-42-git-send-email-pbonzini@redhat.com>
	<1bd28f71-6c37-2739-f181-4d8796fedb2c@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <037c6301-8c15-2bd9-3b34-4bb948661138@redhat.com>
Date: Thu, 31 Jan 2019 23:14:42 +0100
MIME-Version: 1.0
In-Reply-To: <1bd28f71-6c37-2739-f181-4d8796fedb2c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 41/52] isa: express dependencies with
 kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: yang.zhong@intel.com, thuth@redhat.com

On 31/01/19 22:22, Philippe Mathieu-Daud=C3=A9 wrote:
> I kinda disagree with the SuperIO generated configs here, but partly my
> fault because the previous Makefile.objs missed the CONFIG_ISA_SUPERIO
> (I missed to review eae2e2e96bf from Thomas where is introduced
> CONFIG_SMC37C669).
> So introducing ISA_SUPERIO simplifies this files and SouthBridge
> devices. I'm not sure how to provide this patch:

The problem is different SuperIO chips can have or lack
floppy/serial/parallel, and so they end up having different dependencies.

Config symbols are a tool to generate working QEMUs (where working =3D
build and pass device-introspect-test more or less), they needn't
reflect precisely the topology of the machine.

Paolo
