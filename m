Received: from eggs.gnu.org ([209.51.188.92]:40272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMac4-0000Rn-Us
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMac2-0003Ad-Tz
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:00:40 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:41637)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMac1-00038c-8D
	for qemu-devel@nongnu.org; Fri, 03 May 2019 12:00:38 -0400
Received: by mail-oi1-x22e.google.com with SMTP id v23so4795655oif.8
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 09:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553510737.git.damien.hedde@greensocs.com>
	<bf7dcbc7-5dc6-6269-87e9-44f027946cd9@greensocs.com>
	<CAFEAcA8e9Ua8p4LQ=VFkZE69_vr+-EW-bjKX9W-LmgZmvho7Sw@mail.gmail.com>
In-Reply-To: <CAFEAcA8e9Ua8p4LQ=VFkZE69_vr+-EW-bjKX9W-LmgZmvho7Sw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 17:00:24 +0100
Message-ID: <CAFEAcA-TrYPeESbxOjpd49F+iZHWSrwwpRwai21_jhmZJ0Xonw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC 00/17] multi-phase reset mechanism
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Damien Hedde <damien.hedde@greensocs.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgar.iglesias@xilinx.com>, Mark Burton <mark.burton@greensocs.com>, qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@wdc.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Luc Michel <luc.michel@greensocs.com>

On Mon, 29 Apr 2019 at 10:41, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 29 Apr 2019 at 10:36, Damien Hedde <damien.hedde@greensocs.com> wrote:
> >
> > Hi All,
> >
> > Any comment about this ?
>
> Sorry we haven't got to this yet. This is on my to-review list,
> but so are 23 other series, and I've been on holiday for the
> past week or so. I will try to get to it this week.

I made a start on this, but it's going to take me some time
to wrap my head around the design and the issues you raise
in the cover letter. Given the bank holiday on Monday and
some other commitments I have on Tuesday I think it's going
to be the second half of next week at best before I can
do a proper response.

In general I like the code (though as you say we may not
have got the interface quite right -- I had not appreciated
some of the nested-reset cases when I proposed it I think).

I think we could use a document (which would eventually live
in docs/devel) that describes the reset system and provides some
how-to style documentation for
 * what you need to do if you're writing a device
 * what you need to do if you are an external user of
   a device model and you want to reset it
plus some notes on whatever we still have left over as
remnants of the old reset scheme and any intended transitions
to try to remove those remnants. I'll have a go at writing
something because I think that will help me personally in
trying to understand the problem domain and what the new
design is doing.

thanks
-- PMM
