Received: from eggs.gnu.org ([209.51.188.92]:47280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1guK9o-0000Yx-Pq
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:46:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1guK9g-0000yv-Kn
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:46:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:23725)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1guK9T-0000gz-LN
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 11:46:23 -0500
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-42-git-send-email-pbonzini@redhat.com>
	<1bd28f71-6c37-2739-f181-4d8796fedb2c@redhat.com>
	<037c6301-8c15-2bd9-3b34-4bb948661138@redhat.com>
	<6cc1cdd3-edec-c30e-6524-6585dcf007f2@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <111fceb4-65cf-3736-98b6-8467c80bfc00@redhat.com>
Date: Thu, 14 Feb 2019 17:46:02 +0100
MIME-Version: 1.0
In-Reply-To: <6cc1cdd3-edec-c30e-6524-6585dcf007f2@redhat.com>
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

On 31/01/19 23:24, Philippe Mathieu-Daud=C3=A9 wrote:
> The model implementation is:
> - abstract SuperIO parent which can instantiate all configs,
> - child implementation.
>=20
> Childs require their parent, and even if the parent will instantiate
> them without all properties, the parent needs to link with them.
>=20
> In short, if a SuperIO child requires ISA_SUPERIO, it also requires to
> link to serial/parallel/floppy/ide.

It depends... Some SuperIO chips (children) do not have full
functionality, and will never have one or more of
serial/parallel/floppy/ide.  This is why I left the choice of
"select"ing the components in the children.  The code already has to set
up ISASuperIOClass, so there is knowledge of what to select.

Paolo
