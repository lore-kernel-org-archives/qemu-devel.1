Received: from eggs.gnu.org ([2001:4830:134:3::10]:56706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dcavt-0000R0-AI
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 13:26:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dcavq-0000qc-Md
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 13:26:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dcavq-0000qD-G2
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 13:26:10 -0400
References: <150160611982.36.12492156362530631521@93e45bedd699>
	<09b423f3-c9fe-77de-c6df-4ed79f0fa9bf@redhat.com>
	<CAFEAcA9Mea6ysDVm76rf20HKC+z1jcMfM88zmCdHod=jt1e62Q@mail.gmail.com>
	<1743b106-1217-92ee-589d-9ba99f76556d@redhat.com>
	<CAFEAcA_ikSRG6+dMuDeuJG_=S2G7Yk-nsHzORGGKZ8gaC6i=zw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7b1f1648-8581-27ab-ba28-337d3950868d@redhat.com>
Date: Tue, 1 Aug 2017 19:26:02 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_ikSRG6+dMuDeuJG_=S2G7Yk-nsHzORGGKZ8gaC6i=zw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/17] Misc changes for QEMU 2.10-rc1 (?)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>

On 01/08/2017 19:22, Peter Maydell wrote:
> On 1 August 2017 at 18:17, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> Ok, for this patch I kept it consistent within the file, but for 2.11 we
>> can change everything to "while (0)".
> 
> Is this a proposal to bite the bullet and fix all our
> code style issues in existing code? :-)

Only "while (0)" :)

> It would be an interesting question to find out what % of
> QEMU's lines of code have not been touched in the six
> years since we added checkpatch, and how they're
> distributed in the codebase (are there any neat
> visualisations of this sort of thing?) Fix-when-touched
> works OK where we're actively working but can leave
> some big dead spots I suspect.

That's an interesting idea.  Since I've been volunteered to present
about QEMU at KVM Forum, I might give it a shot.

Paolo
