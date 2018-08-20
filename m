Received: from eggs.gnu.org ([2001:4830:134:3::10]:33491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1frdZn-0005na-Kb
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 02:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1frdZi-0001XV-EY
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 02:22:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41062 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1frdZi-0001Wz-A7
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 02:22:02 -0400
References: <20180817161404.9420-1-peter.maydell@linaro.org>
	<0e358562-7607-9c27-d452-57e3dc32806e@redhat.com>
	<CAFEAcA9OmzWrn_cZS5me+xYEMygWg1tYvT3dpbLWER1n-EgwmQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c6e23061-36b5-8572-e746-1d2a54052d2e@redhat.com>
Date: Mon, 20 Aug 2018 08:21:58 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9OmzWrn_cZS5me+xYEMygWg1tYvT3dpbLWER1n-EgwmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tests/boot-serial-test: Bump timeout to 6
 minutes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On 2018-08-18 12:10, Peter Maydell wrote:
> On 18 August 2018 at 10:07, Thomas Huth <thuth@redhat.com> wrote:
>> 6 minutes is really a lot already. I guess most users will hit CTRL-C
>> before waiting so long if there is a realy problem here ... If the
>> current tests just takes a little bit more than 1 minute on the Sparc
>> machine, maybe 2 or 3 minutes would sufficient, too?
> 
> Or maybe not. I don't like tests that run close to their timeout
> limits, because that tends to mean that my automated test runs
> are flaky when the machine happens to be heavily loaded when
> a test is running. I think the purpose of a timeout is to prevent
> the test run hanging indefinitely; as you say, console users can
> hit ctrl-c if they get bored anyway.

... or maybe somebody tries to run TCI on a Sparc host one day ... ok,
you've convinced me, let's go with the 360 seconds:

Reviewed-by: Thomas Huth <thuth@redhat.com>

Paolo, could you please queue up this patch (since I don't have anything
else pending for assembling a PULL request)?

 Thomas
