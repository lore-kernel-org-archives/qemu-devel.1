Received: from eggs.gnu.org ([2001:4830:134:3::10]:38222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTkQ5-0000yJ-Kk
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 04:49:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTkQ4-000215-Tu
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 04:49:21 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:33975)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTkQ4-0001zp-Ft
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 04:49:20 -0400
Received: by mail-oi0-x242.google.com with SMTP id i205-v6so8179373oib.1
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 01:49:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ddf0a4cf-2286-9d3d-ea18-f61865f40fa9@redhat.com>
References: <20180611141716.3813-1-peter.maydell@linaro.org>
	<650048df-f4b1-b351-f877-be8c84197ba2@linaro.org>
	<CAFEAcA-vZH0KUxi+iYP3eYzXeHxNTotNwCMhEPcGhOLksbG71A@mail.gmail.com>
	<f9beda14-7c4a-8f89-baf1-5a79e847c4ac@redhat.com>
	<CAFEAcA_egToeW7ksTncbFCsW6uTh1FcPSgW6gx+VnjvQpqwWsw@mail.gmail.com>
	<ba6b4e80-c31a-6033-ea59-b4c4f1923be7@redhat.com>
	<ddf0a4cf-2286-9d3d-ea18-f61865f40fa9@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 09:48:59 +0100
Message-ID: <CAFEAcA9ODGbSvZARP8hYhwFRbhNg13+Eq02s64a1Y=LO_DJCVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] CODING_STYLE: Define our preferred form
 for multiline comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, "patches@linaro.org" <patches@linaro.org>, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>

On 15 June 2018 at 05:43, Thomas Huth <thuth@redhat.com> wrote:
> On 14.06.2018 22:11, John Snow wrote:
>> Do you have a proposed standard / do we have some consensus on which
>> generator tool or doc format we'd most like to see in QEMU? I could put
>> in some elbow grease to shine up the block layer if so...
>
> I remember that some years ago, somebody (I forgot who it was, sorry)
> once told me that we should use the same format in QEMU as in glib, i.e.
> GTK-Doc. But citing the GTK-Doc homepage: "For a more polished
> general-purpose documentation tool you may want to look at Doxygen" - so
> maybe that's the better choice instead.

The last round of email threads on this basically concluded that
we should use sphinx, which is what the kernel uses. So kernel-doc
comment format, and rst for standalone docs files. Some tidying
up of our current doc comments would be required (which are a bit
of a mishmash of styles plus syntax errors because we've never
done any kind of processing of them to keep us from making mistakes).

thanks
-- PMM
