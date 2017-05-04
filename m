Received: from eggs.gnu.org ([2001:4830:134:3::10]:42827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d6D7S-0004Hb-Ab
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:32:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d6D7R-0002lS-Ao
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:32:18 -0400
Received: from mail-lf0-x22f.google.com ([2a00:1450:4010:c07::22f]:35251)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1d6D7R-0002l2-3A
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:32:17 -0400
Received: by mail-lf0-x22f.google.com with SMTP id j1so4530052lfh.2
	for <qemu-devel@nongnu.org>; Thu, 04 May 2017 02:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <1493725969-19518-1-git-send-email-amarnath.valluri@intel.com>
	<1493725969-19518-7-git-send-email-amarnath.valluri@intel.com>
	<CAJ+F1CKbZjz0PhZEvJ1MmMH4ngkBcOATpU+1HGn=MJDF+YYQLQ@mail.gmail.com>
	<1aa7a139-5d26-00f4-4ebd-72e091b1dd20@intel.com>
In-Reply-To: <1aa7a139-5d26-00f4-4ebd-72e091b1dd20@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 04 May 2017 09:32:05 +0000
Message-ID: <CAJ+F1CJJK6e6JDmvxzoVhZs-wT0ziGOO6_y62_zMXyUL6xjjSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
To: Amarnath Valluri <amarnath.valluri@intel.com>, qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, patrick.ohly@intel.com, berrange@redhat.com

On Thu, May 4, 2017 at 1:23 PM Amarnath Valluri <amarnath.valluri@intel.com=
>
wrote:

>
>
> On 05/02/2017 06:54 PM, Marc-Andr=C3=A9 Lureau wrote:
>
> Hi
>
> On Tue, May 2, 2017 at 3:53 PM Amarnath Valluri <
> amarnath.valluri@intel.com> wrote:
>
>> Provide base implementation of realloc_buffer(), so that backend
>> implementations
>> can resue.
>>
>>
> I doubt that base class facility helps at this point, and would suggest
> moving it to tpm-tis only.
>
> The intention here is to provided the default implementation in base
> class, still backends can overwrite with their suitable reallocation size=
.
>
>
But no other backend uses it.
--=20
Marc-Andr=C3=A9 Lureau
