Received: from eggs.gnu.org ([2001:4830:134:3::10]:57560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cW3BR-0006QD-3T
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 10:38:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cW3BQ-0005oU-8z
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 10:38:57 -0500
Received: from mail-vk0-x22a.google.com ([2607:f8b0:400c:c05::22a]:33065)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cW3BQ-0005o5-3s
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 10:38:56 -0500
Received: by mail-vk0-x22a.google.com with SMTP id k127so114078690vke.0
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 07:38:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJBkM9tJdi7thJSzMY_tqUFy=O-WALtVmYA2h2QYryJPQ@mail.gmail.com>
References: <1485266538-10119-1-git-send-email-peter.maydell@linaro.org>
	<CAJ+F1CJBkM9tJdi7thJSzMY_tqUFy=O-WALtVmYA2h2QYryJPQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jan 2017 15:38:34 +0000
Message-ID: <CAFEAcA8WKghLcJZLSkPoipGPPsaeqZpDwpPQv2iO4rhss2H=ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Makefile: Add qemu-doc.txt to distclean
 and dependencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 24 January 2017 at 14:16, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
> Hi
>
> On Tue, Jan 24, 2017 at 6:05 PM Peter Maydell <peter.maydell@linaro.org>
> wrote:
>>
>> When qemu-doc.txt was added as a new output format in
>> commit f8bab10b4c3f, it was not added to either the
>> list of files to remove in distclean or to the dependency
>> line that forces qemu-options.texi to be built before
>> attempting to build qemu-doc.*.
>>
>> In particular, the missing dependency meant that on
>> some platforms (notably OSX hosts) we would try to
>> build qemu-doc.txt before qemu-options.texi had been
>> fully written out, and then makeinfo would complain
>> about missing cross-reference targets.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
>
>
> good catch, sorry about the regression
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks; applied to master as a buildfix.

-- PMM
