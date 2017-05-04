Received: from eggs.gnu.org ([2001:4830:134:3::10]:40956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1d6Cyn-0001lD-9R
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:23:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1d6Cyj-0006A9-Bz
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:23:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:53331)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1d6Cyj-00069b-3y
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:23:17 -0400
References: <1493725969-19518-1-git-send-email-amarnath.valluri@intel.com>
	<1493725969-19518-7-git-send-email-amarnath.valluri@intel.com>
	<CAJ+F1CKbZjz0PhZEvJ1MmMH4ngkBcOATpU+1HGn=MJDF+YYQLQ@mail.gmail.com>
From: Amarnath Valluri <amarnath.valluri@intel.com>
Message-ID: <1aa7a139-5d26-00f4-4ebd-72e091b1dd20@intel.com>
Date: Thu, 4 May 2017 12:25:20 +0300
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKbZjz0PhZEvJ1MmMH4ngkBcOATpU+1HGn=MJDF+YYQLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 6/8] tpm-backend: Move realloc_buffer()
 implementation to base class
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



On 05/02/2017 06:54 PM, Marc-André Lureau wrote:
> Hi
>
> On Tue, May 2, 2017 at 3:53 PM Amarnath Valluri 
> <amarnath.valluri@intel.com <mailto:amarnath.valluri@intel.com>> wrote:
>
>     Provide base implementation of realloc_buffer(), so that backend
>     implementations
>     can resue.
>
>
> I doubt that base class facility helps at this point, and would 
> suggest moving it to tpm-tis only.
The intention here is to provided the default implementation in base 
class, still backends can overwrite with their suitable reallocation size.

- Amarnath
