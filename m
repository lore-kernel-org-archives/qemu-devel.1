Received: from eggs.gnu.org ([2001:4830:134:3::10]:39919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fxAHj-0005FZ-1c
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 08:18:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fxAHd-00066V-J1
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 08:18:18 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:46590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fxAHd-00065l-6q
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 08:18:13 -0400
Received: by mail-oi0-x22b.google.com with SMTP id y207-v6so6172388oie.13
	for <qemu-devel@nongnu.org>; Tue, 04 Sep 2018 05:18:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180904103213.GB2529@work-vm>
References: <CD29DCF7-6537-406F-A127-6A2FFDDAAD79@caviumnetworks.com>
	<87k1ohxik4.fsf@trasno.org>
	<3BE04368-1463-419A-8A40-EFC8015049B9@caviumnetworks.com>
	<20180828172739.GA10175@work-vm>
	<19EED7A8-CE42-4C46-9CB3-01DEB63FCE79@caviumnetworks.com>
	<20180829131653.gk4yhjdi2pk5bdcd@kamzik.brq.redhat.com>
	<DC466FE6-98B4-485B-BE4D-C4E228B36107@caviumnetworks.com>
	<20180831111121.n7zafn6peiwe6ojn@kamzik.brq.redhat.com>
	<1604D594-E6D4-48BB-A270-F7CF1092978B@caviumnetworks.com>
	<20180904095402.izdnqag3xak3mgsb@kamzik.brq.redhat.com>
	<20180904103213.GB2529@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Sep 2018 13:17:51 +0100
Message-ID: <CAFEAcA9Qj0KVvPgerGbMBf8PgsbWFWqQuuzmMr6k58PGDdERPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Query] Live Migration between machines with
 different processor ids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Andrew Jones <drjones@redhat.com>, Auger Eric <eric.auger@redhat.com>, Juan Quintela <quintela@redhat.com>, "peter.maydell@linaro.org qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Jaggi, Manish" <Manish.Jaggi@cavium.com>

On 4 September 2018 at 11:32, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
> * Andrew Jones (drjones@redhat.com) wrote:
>>  Simply, users that migrate '-cpu host' VMs need to know what they're
>> doing.
>
> The problem here is that in the x86 world we've said:
>   'don't use -cpu host
>    if you're using it be careful and you need to know what you're doing'
>
> on ARM it's looking like the default; that means lots more people will
> use it who don't know what they're doing.

It is also the case that on Arm migration of -cpu host means you
need to know what you're doing. But also, we don't support any
kind of cross-cpu-type migration or "present cpu type A to the guest
when running cpu type B", so a lot of the things you can do on
x86 just aren't possible (yet) on Arm. The vague plan has been that
we should fill in the gaps generally in line with what x86 does.
But as Andrew says the errata-workaround-enablement issue is a bit
tricky.

thanks
-- PMM
