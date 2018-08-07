Received: from eggs.gnu.org ([2001:4830:134:3::10]:54107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fn1zc-00027G-LS
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:25:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fn1zb-00019C-T5
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:25:44 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:44016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fn1zb-000196-N6
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 09:25:43 -0400
Received: by mail-oi0-x242.google.com with SMTP id b15-v6so28339409oib.10
	for <qemu-devel@nongnu.org>; Tue, 07 Aug 2018 06:25:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_m+81aDQR=n=8gXhcifYp0L6n9KZA5COQsRejeqZe2FQ@mail.gmail.com>
References: <20180807130355.29780-1-peter.maydell@linaro.org>
	<87muty2u57.fsf@trasno.org>
	<CAFEAcA_m+81aDQR=n=8gXhcifYp0L6n9KZA5COQsRejeqZe2FQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Aug 2018 14:25:22 +0100
Message-ID: <CAFEAcA8J3XiBWZ_a8-Pz2nVsNTV9bEedm2YV6OkO=GOLNpyfkg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] migration: Correctly handle subsections
 with no 'needed' function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 7 August 2018 at 14:21, Peter Maydell <peter.maydell@linaro.org> wrote:
>  If you want to make it a bug to
> not have a needed function, you need to have code that checks
> for this in device init and aborts, so that device authors
> don't fall into this trap.

We should also sanity-check the subsection names at device
init, because there's a hidden requirement that they start
with the name of the parent VMSD, and if you get that wrong
then nothing complains except that trying to reload the
vm state silently doesn't work right.

thanks
-- PMM
