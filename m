Received: from eggs.gnu.org ([2001:4830:134:3::10]:58754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9bLy-00073o-50
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 14:33:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9bLu-00045j-UQ
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 14:33:32 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:50243)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e9bLu-00044l-Ne
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 14:33:30 -0400
Received: by mail-wm0-x231.google.com with SMTP id s66so652578wmf.5
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 11:33:28 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Oct 2017 18:33:06 +0000
Message-ID: <CAFEAcA81ENKOYTCvhpBrXnreyy9zodk-EXqvwLZq=1w6UvkoAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] we allow passing -machine type=foo more than once but
 are confused about which to use...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>

(cc Markus because I know how much he likes weirdnesses in our
command line parsing :-))

https://stackoverflow.com/questions/46955244/qemu-run-arm-ubuntu-unsupported-machine-type/47042282
has a user who's run into a confusing error message, because
we allow the user to pass "-machine type=foo" more than once on
the command line. When we decide which one to use, we go with the
last one on the list. However if it's not valid, when we print the
"don't recognize that machine type" message, the name we use in
the message is the *first* one on the list :-)

Maybe we should just not allow users to pass the argument
more than once...?

thanks
-- PMM
