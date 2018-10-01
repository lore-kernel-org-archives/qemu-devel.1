Received: from eggs.gnu.org ([2001:4830:134:3::10]:56333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g6tgr-0006gc-Q9
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:36:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g6tgp-0007JT-GJ
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:36:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35964)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g6tgp-0007Hs-8K
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 04:36:27 -0400
References: <1538295197-23704-1-git-send-email-pbonzini@redhat.com>
	<572f8674-1712-686a-278e-9eae5947a233@amsat.org>
	<5a4400ff-5eed-6deb-9986-a63abca495b6@redhat.com>
	<22b1d8c9-50fb-6317-eff7-1bd9376be851@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1c391f19-9396-8b0a-2205-b5c1d1ff60c5@redhat.com>
Date: Mon, 1 Oct 2018 10:36:24 +0200
MIME-Version: 1.0
In-Reply-To: <22b1d8c9-50fb-6317-eff7-1bd9376be851@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/79] Misc QEMU patches for 2018-09-30
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

On 01/10/2018 10:25, Philippe Mathieu-Daud=C3=A9 wrote:
>> I'll fix it.  In the meanwhile, I'll note that we're also improving
>> Patchew so that it is much better at applying patches via three-way
>> merge (basically the adding of *-by tags moves from "patchew apply" to
>> the web stuff) and that should make these UTF-8 issues a thing of the =
past.
> I noticed my patches are missing C=C3=A9dric's R-b tags, is it a patche=
w
> restriction?

No, it's just that sometimes I apply patches before I get the R-b (maybe
I'm not connected to the VPN and haven't downloaded all the messages).

Basically:

- if I apply with Patchew, all tags are correct but I can only do that
if there are no conflicts

- if I apply by hand, there may be missing tags and (because
Thunderbird's "view source" stupidly defaults to Latin-1) incorrect UTF-8=
.

Paolo
