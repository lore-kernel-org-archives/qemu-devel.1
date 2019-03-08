Received: from eggs.gnu.org ([209.51.188.92]:37645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h2DjT-0003c2-S5
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:32:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h2DjS-0004ek-0d
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:32:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1h2DjQ-0004BU-Fm
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:32:05 -0500
References: <20190225133744.7095-1-weijiang.yang@intel.com>
	<20190225133744.7095-2-weijiang.yang@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <91e76add-e9bb-a81b-be43-d32dea97050f@redhat.com>
Date: Fri, 8 Mar 2019 12:31:52 +0100
MIME-Version: 1.0
In-Reply-To: <20190225133744.7095-2-weijiang.yang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/5] Add CET xsaves/xrstors related
 macros and structures.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Weijiang <weijiang.yang@intel.com>, cdupontd@redhat.com, rkrcmar@redhat.com, qemu-devel@nongnu.org, mst@redhat.com
Cc: Zhang Yi <yi.z.zhang@linux.intel.com>

On 25/02/19 14:37, Yang Weijiang wrote:
> +
>  typedef struct X86XSaveArea {
>      X86LegacyXSaveArea legacy;
>      X86XSaveHeader header;
> @@ -1039,6 +1070,9 @@ typedef struct X86XSaveArea {
>      XSaveHi16_ZMM hi16_zmm_state;
>      /* PKRU State: */
>      XSavePKRU pkru_state;
> +    /* CET State: */
> +    XSaveCETU cet_u;
> +    XSaveCETS cet_s;
>  } X86XSaveArea;
> =20

Hi,

CET state should be retrieved or set not via XSAVE, but rather with
KVM_GET/SET_MSR, so this part is not needed.

Paolo
