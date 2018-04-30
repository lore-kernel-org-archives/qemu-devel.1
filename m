Received: from eggs.gnu.org ([2001:4830:134:3::10]:50203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fD9p9-0003zq-91
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 10:30:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fD9p5-0003Kf-As
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 10:30:39 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:43579)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fD9p5-0003KB-5M
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 10:30:35 -0400
Received: by mail-oi0-x241.google.com with SMTP id p62-v6so7544527oie.10
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 07:30:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180430162359.5c963c50@bahia.lan>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<20180430162359.5c963c50@bahia.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Apr 2018 15:30:13 +0100
Message-ID: <CAFEAcA9BNjAhAt-QSmWVQuH3GsujGLswcPDJ9CazHeabnswRsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On 30 April 2018 at 15:23, Greg Kurz <groug@kaod.org> wrote:
> On Fri, 27 Apr 2018 16:51:03 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
>> Hi; I usually let people forget about releases for a month or
>> so before bringing this topic up, but:
>>
>> (1) do we want to call the next release 2.13, or something else?
>> There's no particular reason to bump to 3.0 except some combination of
>>  * if we keep going like this we'll get up to 2.42, which starts to
>>    get silly
>>  * Linus-style "avoid being too predictable"
>>  * triskaidekaphobia
>> but maybe we should anyway?
>>
>
> Do we care for machine versions to stick to QEMU versions ? I ask,
> because we've already added a pseries-2.13 machine type (in master
> since David's latest pull req). No big deal though if we have to
> turn it into pseries-3.0 I guess...

Yeah, we'd just bump that to pseries-3.0.

(We should probably have some more formal process for ensuring
that all our versioned machines get a version for the new
release at some point before rc0. We've been close to forgetting
for virt once or twice.)

thanks
-- PMM
