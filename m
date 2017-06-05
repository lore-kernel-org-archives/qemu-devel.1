Received: from eggs.gnu.org ([2001:4830:134:3::10]:50529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dHrm9-0005gs-CP
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 09:10:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dHrm8-0001GO-MY
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 09:10:29 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:36171)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dHrm8-0001Fk-G5
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 09:10:28 -0400
Received: by mail-wm0-x22a.google.com with SMTP id 7so72764151wmo.1
	for <qemu-devel@nongnu.org>; Mon, 05 Jun 2017 06:10:28 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Jun 2017 14:10:06 +0100
Message-ID: <CAFEAcA_pErWnoUh_-fxaBMZB1L=4jYxUXYfx9CA5uVnx0H2_pw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] qdev properties vs qom object properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

I perpetually get confused about qdev properties vs QOM object
properties.

Why do we have both of these APIs?
How do they interact?
Which is the recommended one for new device code?
Do we have a transition plan for old code?
Where should I be looking for the documentation on this?

For a specific example, I see that target/arm is the only code
using qdev_property_add_static(), but there's no indication
that the function is deprecated or what the right thing to be
doing instead is. Any suggestions?

thanks
-- PMM
