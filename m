Received: from eggs.gnu.org ([209.51.188.92]:37827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h0riX-0001jd-RT
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:49:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h0riX-0001tp-59
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:49:33 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:40387)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h0riW-0001sp-T4
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 12:49:33 -0500
Received: by mail-ot1-x333.google.com with SMTP id v20so4954714otk.7
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 09:49:32 -0800 (PST)
MIME-Version: 1.0
References: <20190304164958.9362-1-peter.maydell@linaro.org>
	<20190304164958.9362-2-peter.maydell@linaro.org>
	<d3159873-3907-d97e-65e1-8d34137fb345@redhat.com>
In-Reply-To: <d3159873-3907-d97e-65e1-8d34137fb345@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2019 17:49:20 +0000
Message-ID: <CAFEAcA8jam0hdUDez5mi7h3+PrhUWmWBWa0yfOtY0rHjNmTYvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 1/7] ui/cocoa: Ensure we have the iothread
 lock when calling into QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Mon, 4 Mar 2019 at 17:45, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> Hi Peter,
>
> On 3/4/19 5:49 PM, Peter Maydell wrote:
> > The Cocoa UI should run on the main thread; this is enforced
> > in OSX Mojave. In order to be able to run on the main thread,
> > we need to make sure we hold the iothread lock whenever we
> > call into various QEMU UI midlayer functions.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
> > Tested-by: Roman Bolshakov <r.bolshakov@yadro.com>
>
> I got surprised by your 2 Message-id lines (same with other patches from
> this pull request):
>
> > Message-id: 20190225102433.22401-2-peter.maydell@linaro.org
>
> ^ v3
>
> > Message-id: 20190214102816.3393-2-peter.maydell@linaro.org

I think the 'patches' program tends to add an extra
Message-id: line even if one was already present. I treat
this header as pure noise and do not attempt to either add
it or remove it by hand.

thanks
-- PMM
