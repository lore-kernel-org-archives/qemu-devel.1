Received: from eggs.gnu.org ([2001:4830:134:3::10]:38213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dpWVT-0002ST-GO
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 05:20:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1dpWVN-0001p4-Kc
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 05:20:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1dpWVN-0001oq-ER
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 05:20:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2ACE62027B
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 09:20:16 +0000 (UTC)
References: <cover.1504688205.git.mprivozn@redhat.com>
	<5defe9fcfacaae68ebbdb76b3ec4b565bf4e7d1c.1504688205.git.mprivozn@redhat.com>
	<20170906090442.GJ15510@redhat.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <f0a4fbf1-a1dc-03c2-25ad-6eaf6bec96e4@redhat.com>
Date: Wed, 6 Sep 2017 11:20:14 +0200
MIME-Version: 1.0
In-Reply-To: <20170906090442.GJ15510@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/2] watchdog: Allow setting action on
 the fly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com

On 09/06/2017 11:04 AM, Daniel P. Berrange wrote:
> On Wed, Sep 06, 2017 at 10:58:54AM +0200, Michal Privoznik wrote:
>> Currently, the only time that users can set watchdog action is at
>> the start as all we expose is this -watchdog-action command line
>> argument. This is suboptimal when users want to plug the device
>> later via monitor. Alternatively, they might want to change the
>> action for already existing device on the fly.
>>
>> At the same time, drop local redefinition of the actions enum in
>> watchdog.h in favour of the ones defined in schema and thus kills
>> code duplication.
> 
> Nit-pick - I'd suggest 2 separat patches - one that drops the enum
> redefinition, and the second which adds the new monitor command.
> That way you separate no-op refactoring, from new features.

Sure. We prefer that in libvirt too. Let me respin v4.

Michal
