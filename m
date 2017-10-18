Received: from eggs.gnu.org ([2001:4830:134:3::10]:38810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e4pLw-0000VB-SE
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:29:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e4pLt-00045I-Is
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:29:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e4pLt-00044A-Co
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 10:29:45 -0400
References: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
	<20171016163636.GI11975@redhat.com>
	<20171017092702.5b82103b@nial.brq.redhat.com>
	<20171017150759.GB31897@redhat.com>
	<32e47d96-0292-4511-adb2-24a4766b3027@redhat.com>
	<20171018122715.GF9719@redhat.com>
	<f281298d-f9b3-7ffe-e223-ccd596bb0545@redhat.com>
	<20171018162625.094cd3e1@nial.brq.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3039cb1b-cef6-781b-964c-143ab225a88f@redhat.com>
Date: Wed, 18 Oct 2017 16:29:38 +0200
MIME-Version: 1.0
In-Reply-To: <20171018162625.094cd3e1@nial.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 0/6] enable numa configuration before
 machine_init() from HMP/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, peter.maydell@linaro.org, pkrempa@redhat.com, ehabkost@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, david@gibson.dropbear.id.au

On 18/10/2017 16:26, Igor Mammedov wrote:
>> I guess query-hotpluggable-cpus could also grow a first-cpu-index in the
>> returned data.
> 
> I guess query-cpus can/does provide cpu-index already,
> for query-hotpluggable-cpus it would depend in what's shown there
> (would work fro x86/arm/s390 as they publish there CPUState based objects,
> but spapr puts cores there which themselves do not have cpu-index,
> their children do though)

Yeah, that's why I put "first-cpu-index".  The idea is that indices go
from first-cpu-index to first-cpu-index + vcpus-count - 1.

Paolo
