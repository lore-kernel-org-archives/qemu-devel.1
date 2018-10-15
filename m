Received: from eggs.gnu.org ([2001:4830:134:3::10]:37767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gBzho-0003VY-B0
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 06:02:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gBzhn-0005V8-Dd
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 06:02:32 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:37115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gBzhl-0005RC-DO
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 06:02:30 -0400
Received: by mail-oi1-x242.google.com with SMTP id e17-v6so14600542oib.4
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 03:02:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181015093243.GE6785@redhat.com>
References: <20181013050227.17022-1-ehabkost@redhat.com>
	<20181015093243.GE6785@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Oct 2018 11:02:03 +0100
Message-ID: <CAFEAcA8MQ37JVCCPGyQa20n6AuU8Sv_pC9DoDoCKdQhqekpGnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] Require Python 3 for building QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 15 October 2018 at 10:32, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
> On Sat, Oct 13, 2018 at 02:02:27AM -0300, Eduardo Habkost wrote:
>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>> ---
>> I'd like to do this in QEMU 3.1.  I think it's time to drop
>> support for old systems that have only Python 2.
>>
>> We still have a few scripts that are not required for building
>> QEMU that still work only with Python 2 (iotests being the most
>> relevant set).  Requiring Python 3 for building QEMU won't
>> prevent people from using those scripts with Python 2 until they
>> are finally ported.
>
> I think it is premature & unecessary to do this. We just got QEMU buildin=
g
> with dual Python2/3 in 3.0 to give people leeway in the migration path to
> a fully v3 future. The code to support building 2/3 in parallel is not
> imposing a unreasonable maint burden. Dropping py2 suport would have
> negligible impact on the code, as there's no v3-only features we have
> used. IOW, I don't think there's a compelling reason to rush into forcing
> users onto v3.
>
> If we want to drop py2, we should give people a warning of such a planned
> change, especially since some of our targetted host OS[1] don't even
> include a py3 as standard without acquiring extra add-on repos. Devs in
> a typical corporate env will not have the freedom to install such extra
> repos on their machines.

I agree. I also think that dropping python 2 support before we've
even converted all our python scripts to handle python 3 is the
wrong order to do things. People interested in moving forward with
the transition to python-3-only should start by making sure everything
we have works with python 3...

thanks
-- PMM
