Received: from eggs.gnu.org ([2001:4830:134:3::10]:59213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cq0EP-0006BU-Il
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 12:32:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cq0EO-0002nr-SC
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 12:32:29 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:36289)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cq0EO-0002nh-Ky
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 12:32:28 -0400
Received: by mail-wm0-x232.google.com with SMTP id n11so68042451wma.1
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 09:32:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87bmsv29ok.fsf@dusky.pond.sub.org>
References: <1490021158-4469-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA_QWrU6AGfWz1iNfgYJUuKJ=hyUOHkPOo8XKyyV=4WOSw@mail.gmail.com>
	<87bmsv29ok.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Mar 2017 16:32:06 +0000
Message-ID: <CAFEAcA-XZ-STrvzv4nrxrMCd3ureKXpLeAFpoPktNYb++YMusQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2] hmp: gpa2hva and gpa2hpa hostaddr
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 20 March 2017 at 16:29, Markus Armbruster <armbru@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>> I have some comments which feel kind of nit-picky, but since this
>> is a public-facing HMP API I think they need attention since we only
>> get one chance to get it right.
>
> HMP is not a stable interface.  If we get it wrong, we change it.  If
> our change breaks your usage, you get to keep the pieces.

Oh yes, I had my HMP and QMP the wrong way round.

...which reminds me that I thought we preferred all HMP commands
to be implemented in terms of their QMP equivalent ?

thanks
-- PMM
