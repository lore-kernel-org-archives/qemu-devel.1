Received: from eggs.gnu.org ([2001:4830:134:3::10]:38882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1frnF6-00022O-G5
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 12:41:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1frnF5-0004db-Oc
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 12:41:24 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:37278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1frnF5-0004dP-Bl
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 12:41:23 -0400
Received: by mail-oi0-x243.google.com with SMTP id j205-v6so26947347oib.4
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 09:41:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180820133137.GH10682@lemon.usersys.redhat.com>
References: <20180820124811.7982-1-peter.maydell@linaro.org>
	<20180820133137.GH10682@lemon.usersys.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 17:41:02 +0100
Message-ID: <CAFEAcA9v=jUdcJRW2UCHSiH8twOo=Lnq1nJxJEkKh5YFHKk3Ww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tests/vm: Clean out old working
 directories on build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 20 August 2018 at 14:31, Fam Zheng <famz@redhat.com> wrote:
> On Mon, 08/20 13:48, Peter Maydell wrote:
>> When we do a build inside one of the BSD VMs, first
>> delete any stale old build directories from the VM's
>> /var/tmp. This prevents the VM from running out of
>> disk space after it has been used for a dozen or
>> so builds.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> The Ubuntu test VM has a similar issue, but it doesn't
>> put its test build directories in /var/tmp/ like the
>> BSDs, and I don't use it so I'm not sure what the right
>> rm command would be. Somebody else can fix it if they care...
>>
>> Disclaimer: not actually tested yet, but obviously it will
>> get tested as part of applying it to master, which I'd
>> like to do so my pullrequest tests don't keep getting
>> tripped up by this bug.
>
> Reviewed-by: Fam Zheng <famz@redhat.com>
>
> Please merge this yourself if it helps your pull request handling workflow.

Thanks; I've applied it to master. We can probably
come up with a cleaner approach with disk snapshots,
but this will suffice to avoid build failures in
the meantime.

-- PMM
