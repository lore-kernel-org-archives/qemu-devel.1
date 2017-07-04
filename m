Received: from eggs.gnu.org ([2001:4830:134:3::10]:35905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dSNUY-00048b-0L
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 09:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dSNUT-0004V9-NZ
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 09:03:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47042)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dSNUT-0004Ug-I8
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 09:03:41 -0400
References: <20170704111404.28569-1-berrange@redhat.com>
	<CAFEAcA9EKaUP_7JgT553fZ2_z2kcg_UsKwdgwQKRQVQMH3fbfA@mail.gmail.com>
	<20170704121618.GK3135@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <feb3149e-2f12-6471-ed6a-980ea21d48ce@redhat.com>
Date: Tue, 4 Jul 2017 15:03:36 +0200
MIME-Version: 1.0
In-Reply-To: <20170704121618.GK3135@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/2] Document deprecated features &
 support lifecycle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 04.07.2017 14:16, Daniel P. Berrange wrote:
> On Tue, Jul 04, 2017 at 01:00:54PM +0100, Peter Maydell wrote:
>> On 4 July 2017 at 12:14, Daniel P. Berrange <berrange@redhat.com> wrote:
>>> This is a followup to
>>>
>>>   v1: https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg02390.html
>>>   v2: https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg01286.html
>>>
>>> The goal is to clarify to users & app developers what they can expect
>>> from QEMU in terms of feature lifecycle & any deprecation policy should
>>> it be neccessary to remove features.
>>>
>>> The list of features marked as deprecated was determined by looking at
>>> the QEMU source for the word "deprecated'. It was then compared with
>>> the doc Thomas put up at http://wiki.qemu.org/Features/LegacyRemoval
>>>
>>> Key differences with the wiki page that Thomas wrote up vs patch 2
>>> in this series
>>>
>>>  - Deprecated features are given a fixed lifespan of 2 releases,
>>>    rather than listing deletion at a future "major" v3.0.0 release.
>>>    This ensures that applications like libvirt have a predictable
>>>    fixed amount of time to react to deprecations.
>>
>> That's 8 months. Is that enough time for QEMU versions to get into
>> distros and out to users? (I don't necessarily think it's too short,
>> but it seems worth thinking about.)
[...]
> I think 2 releases is the minimum acceptable window of deprecation,
> but I also wouldn't object if we wanted to make it 3 release, so
> there's a nice clear "1 year" grace period before deletion. That
> would make it slightly more likely that users of distros would
> see the warning before the feature has actually been deleted.

Last time we discussed this, nobody insisted on 3 releases, so I think
we should start with 2 releases. If somebody complains later that this
is too short, we can still bump it to 3 releases instead.

 Thomas
