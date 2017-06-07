Received: from eggs.gnu.org ([2001:4830:134:3::10]:32786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIbGr-0004gZ-Lu
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 09:45:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIbGr-0008OD-0P
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 09:45:13 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:33915)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dIbGq-0008NK-Nz
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 09:45:12 -0400
Received: by mail-wr0-x22d.google.com with SMTP id g76so6393544wrd.1
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 06:45:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87fufct04g.fsf@dusky.pond.sub.org>
References: <20170531135709.345-1-marcandre.lureau@redhat.com>
	<20170531135709.345-6-marcandre.lureau@redhat.com>
	<878tlct0o3.fsf@dusky.pond.sub.org>
	<CAFEAcA8C2yfwJHyf63pWc5Sxbb+sbTeTpDJG6H4VYARwX=Yxcw@mail.gmail.com>
	<87fufct04g.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Jun 2017 14:44:50 +0100
Message-ID: <CAFEAcA_wVkwDUpJ4phLvz0TBbPG2UTjs6ua5i+YCnb0dWKUH+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 05/45] qdev: remove PropertyInfo.qtype
 field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 7 June 2017 at 14:09, Markus Armbruster <armbru@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>> So how should I obtain those semantics with this cleanup in place ?
>
> Two ways come to mind:
>
> * Define a PropertyInfo like qdev_prop_uint32 with a null
>   set_default_value(), and use that.
>
> * Add a flag to Property that makes qdev_property_add_static() skip
>   prop->info->set_default_value(), set it for your property.
>
>   Actually, I'd probably do it the other way: call ->set_default_value()
>   only when the flag is set.  No need to check it's non-null then.
>   Setting the flag when it's null is a programming error.
>
> Could one of these two work for you?

The former would work but duplicates a pile of code from the
qdev_prop_uint32 implementation. The latter would be cleaner
but introduces a dependency on this series -- how close is it
to hitting master?

thanks
-- PMM
