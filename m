Received: from eggs.gnu.org ([2001:4830:134:3::10]:59528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1dYm0u-0003tq-9a
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 00:27:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1dYm0r-00049V-66
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 00:27:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:12212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1dYm0q-00045u-Rm
	for qemu-devel@nongnu.org; Sat, 22 Jul 2017 00:27:33 -0400
Message-ID: <1500697848.4962.43.camel@intel.com>
From: Amarnath Valluri <amarnath.valluri@intel.com>
Reply-To: amarnath.valluri@intel.com
Date: Sat, 22 Jul 2017 07:30:48 +0300
In-Reply-To: <da24db91-6279-d91c-c102-a5022c6bba10@redhat.com>
References: <1500367747-8992-1-git-send-email-amarnath.valluri@intel.com>
	<1500367747-8992-6-git-send-email-amarnath.valluri@intel.com>
	<CAJ+F1CLcHN1z-ODgvt-C2MT8h1JfbodG=bmBqq4MTj8P8m7ykg@mail.gmail.com>
	<da24db91-6279-d91c-c102-a5022c6bba10@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 5/8] tmp backend: Add new api to read
 backend TpmInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>

On Tue, 2017-07-18 at 09:28 -0500, Eric Blake wrote:
> On 07/18/2017 05:39 AM, Marc-André Lureau wrote:
> > Hi
> > 
> > On Tue, Jul 18, 2017 at 1:49 AM, Amarnath Valluri
> > <amarnath.valluri@intel.com> wrote:
> >> TPM configuration options are backend implementation details and shall not be
> >> part of base TPMBackend object, and these shall not be accessed directly outside
> >> of the class, hence added a new interface method, get_tpm_options() to
> >> TPMDriverOps., which shall be implemented by the derived classes to return
> >> configured tpm options.
> >>
> > One usually prefer to have the true case first.
> > 
> >> +    } else {
> >> +        tpm_pt->ops->has_path = true;
> >>      }
> >>
> >> +    tpm_pt->ops->path = g_strdup(value);
> > 
> > Interestingly, ops->path will be set even if ops->has_path = false. I
> > am not sure the visitors will handle that case properly (for visit or
> > dealloc etc). Could you set ops->has_path = true uncondtionnally?
> 
> tmp_pt->opt->path is ignored if has_path is false; if it is assigned to
> malloc'd memory, then you leak that memory when freeing tpm_pt.
Yes, i agree there is memory leak here, i will fix it.

- Amarnath
