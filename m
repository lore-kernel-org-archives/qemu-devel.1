Received: from eggs.gnu.org ([2001:4830:134:3::10]:56042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1d6CGg-0001NJ-EK
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:37:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1d6CGd-0003f3-AA
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:37:46 -0400
Received: from mga03.intel.com ([134.134.136.65]:1553)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1d6CGc-0003eD-Uf
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:37:43 -0400
References: <1493725969-19518-1-git-send-email-amarnath.valluri@intel.com>
	<1493725969-19518-5-git-send-email-amarnath.valluri@intel.com>
	<CAJ+F1CJC21gXOHuVf09NstSs278Aw9no6H51XPa8_fMgYP+AVQ@mail.gmail.com>
From: Amarnath Valluri <amarnath.valluri@intel.com>
Message-ID: <d8e3697a-003a-446a-6c88-d0717471ae03@intel.com>
Date: Thu, 4 May 2017 11:39:48 +0300
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJC21gXOHuVf09NstSs278Aw9no6H51XPa8_fMgYP+AVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 4/8] tpm-backend: Made few interface
 methods optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, patrick.ohly@intel.com, berrange@redhat.com



On 05/02/2017 03:29 PM, Marc-André Lureau wrote:
>
>
> On Tue, May 2, 2017 at 3:52 PM Amarnath Valluri 
> <amarnath.valluri@intel.com <mailto:amarnath.valluri@intel.com>> wrote:
>
>     This allows backend implementations left optional interface methods.
>     For mandatory methods assertion checks added.
>
>     Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com
>     <mailto:amarnath.valluri@intel.com>> 
>
>     ---
>      backends/tpm.c           | 24 ++++++++++++++++++------
>      hw/tpm/tpm_passthrough.c | 16 ----------------
>      2 files changed, 18 insertions(+), 22 deletions(-)
>
>     diff --git a/backends/tpm.c b/backends/tpm.c
>     index cf5abf1..8245426 100644
>     --- a/backends/tpm.c
>     +++ b/backends/tpm.c
>     @@ -48,7 +48,7 @@ const char *tpm_backend_get_desc(TPMBackend *s)
>      {
>          TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
>
>     -    return k->ops->desc();
>     +    return k->ops->desc ? k->ops->desc() : "";
>      }
>
>
> If it only need to returns const, we may consider using a class field, 
> defaulting to null.
Yes, it makes more sense being a const member than a function pointer.
>
> Who is using it? tpm_backend_get_desc() not being called anywhere. 
> Let's remove it?
Frankly no one using this API, rather it's been accessed 
directly(be_drivers[i]->desc())  in tpm.c. It can be removed.

- Amarnath
