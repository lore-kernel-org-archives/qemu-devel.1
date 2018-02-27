Received: from eggs.gnu.org ([2001:4830:134:3::10]:33239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqjHU-0005nO-KU
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:43:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqjHT-0008Cx-Ja
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:43:12 -0500
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:45456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqjHT-0008Cg-EN
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:43:11 -0500
Received: by mail-oi0-x22a.google.com with SMTP id j79so13482240oib.12
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 09:43:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180227173234.GI32480@stefanha-x1.localdomain>
References: <1519613598-12270-1-git-send-email-suhang16@mails.ucas.ac.cn>
	<20180227173234.GI32480@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 17:42:50 +0000
Message-ID: <CAFEAcA9UftR-D5k9D2RrBUKvGWo_nC-+jfBKZAOjsHUAjyMs0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 RFC] scripts/checkpatch.pl: add check
 for `while` and `for`
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Su Hang <suhang16@mails.ucas.ac.cn>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 27 February 2018 at 17:32, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> On Mon, Feb 26, 2018 at 10:53:18AM +0800, Su Hang wrote:
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index 1b4b812e28fa..10c138344fa9 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -2353,7 +2353,8 @@ sub process {
>>               }
>>
>>  # check for missing bracing round if etc
>
> Please fix the pre-existing typo in the comment:
>
> s/round/around/

That's not really a typo IMHO -- both 'round' and 'around'
seem fine to me here. (The OED entry for 'around' notes
"There is variation with 'round' adv. and prep. in many of the
senses below; in general 'around' is less usual in British usage",
so some of this is US-vs-UK usage or personal idiolect.)

thanks
-- PMM
