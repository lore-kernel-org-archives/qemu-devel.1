Received: from eggs.gnu.org ([2001:4830:134:3::10]:46227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1e4PY7-0005FL-5v
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 06:56:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1e4PY1-0004rT-9H
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 06:56:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1e4PY1-0004r0-3v
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 06:56:33 -0400
References: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
	<1508170976-96869-5-git-send-email-imammedo@redhat.com>
	<20171016163515.GH11975@redhat.com>
	<20171017101707.5ff95d1c@nial.brq.redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <71e77669-5498-78a0-88b6-f634dc3727f6@redhat.com>
Date: Tue, 17 Oct 2017 12:56:28 +0200
MIME-Version: 1.0
In-Reply-To: <20171017101707.5ff95d1c@nial.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 4/6] CLI: add -paused option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: peter.maydell@linaro.org, pkrempa@redhat.com, ehabkost@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, pbonzini@redhat.com, david@gibson.dropbear.id.au

On 10/17/17 10:17, Igor Mammedov wrote:
> On Mon, 16 Oct 2017 17:35:15 +0100
> "Daniel P. Berrange" <berrange@redhat.com> wrote:
> 
>> On Mon, Oct 16, 2017 at 06:22:54PM +0200, Igor Mammedov wrote:
>>
>> This really needs to have a commit message that provides justification
>> for why this option is needed when we already have -S that is used
>> to allow configuration before the guest starts.
> Sorry, I've should have added here what I've tried to describe in cover letter.
> 
> -S pauses machine too late as machine is already created by the time
> it's paused so trying to reconfigure it might require machine to be recreated.
> In case of NUMA options it might be possible to hack x86 target to
> rebuild/override acpi/fw_cfg so it would reflect the new settings set
> this late but I wouldn't expect that it would work in general.
> 
> The cleanest way to configure it is pausing and configuring numa mapping
> before machine is build.

Asking from the sideline: if the NUMA mapping has to be configured so
early, why can't it be done on the QEMU command line?

(I asked myself the same question when I first saw your patches -- I
couldn't find an explanation in the blurb --, so I assumed it was
obvious and/or others would ask the same question.)

Again, I'm just curious.

Thanks!
Laszlo
