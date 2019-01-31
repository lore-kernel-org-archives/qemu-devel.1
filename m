Received: from eggs.gnu.org ([209.51.188.92]:54204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gpKd6-0008Go-6C
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 17:16:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gpKd5-0003iP-CC
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 17:16:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gpKd5-0003i9-39
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 17:16:15 -0500
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-34-git-send-email-pbonzini@redhat.com>
	<6e8609da-a198-4457-afc2-88f911261994@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b925a626-dee7-a95f-2721-a821c6edf209@redhat.com>
Date: Thu, 31 Jan 2019 23:15:52 +0100
MIME-Version: 1.0
In-Reply-To: <6e8609da-a198-4457-afc2-88f911261994@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 33/52] build: switch to Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul.durrant@citrix.com>
Cc: yang.zhong@intel.com, thuth@redhat.com

On 31/01/19 22:48, Philippe Mathieu-Daud=C3=A9 wrote:
> There is something I don't understand here: Does CONFIG_XEN in
> Kconfig.host take precedence over the target configs? I'm looking at
> these configs:
>=20
>  if supported_xen_target $target; then
>      echo "CONFIG_XEN=3Dn" >> $config_target_mak
>      if test "$xen_pci_passthrough" =3D yes; then
>          echo "CONFIG_XEN_PCI_PASSTHROUGH=3Dy" >> "$config_target_mak"
>      fi
>  fi

You're right, Kconfig.host should contain CONFIG_XEN_BACKEND and not
CONFIG_XEN.

Paolo
