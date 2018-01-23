Received: from eggs.gnu.org ([2001:4830:134:3::10]:57054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1edvMu-0007UD-Gi
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 04:59:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1edvMp-0005XE-HU
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 04:59:52 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60512
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1edvMp-0005Wf-BE
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 04:59:47 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0N9x7rE022573
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 04:59:46 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fny1197tk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 04:59:45 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 23 Jan 2018 09:59:44 -0000
References: <20180118020157.25401-1-ehabkost@redhat.com>
	<CAFEAcA_WdJnYnZUoABB1yWZUO81ag2cMMZRAw106VL_GFM6ZcQ@mail.gmail.com>
	<CAATJJ0Kwf=qMQ8Sax8d4ieFXfFrqaisd6wUSLTTLBxvSdgb5Jw@mail.gmail.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 23 Jan 2018 10:59:39 +0100
MIME-Version: 1.0
In-Reply-To: <CAATJJ0Kwf=qMQ8Sax8d4ieFXfFrqaisd6wUSLTTLBxvSdgb5Jw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <1d3ee391-bbb2-3c49-b3b0-8f189e0fd096@de.ibm.com>
Subject: Re: [Qemu-devel] [PULL 0/8] x86 queue, 2018-01-17
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Ehrhardt <christian.ehrhardt@canonical.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>, qemu-ppc@nongnu.org



On 01/23/2018 09:40 AM, Christian Ehrhardt wrote:
> On Thu, Jan 18, 2018 at 2:51 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 18 January 2018 at 02:01, Eduardo Habkost <ehabkost@redhat.com> wrote:
>>> The following changes since commit 8e5dc9ba49743b46d955ec7dacb04e42ae7ada7c:
>>>
>>>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180116' into staging (2018-01-16 17:36:39 +0000)
>>>
>>> are available in the Git repository at:
>>>
>>>   git://github.com/ehabkost/qemu.git tags/x86-pull-request
>>>
>>> for you to fetch changes up to 6cfbc54e8903a9bcc0346119949162d040c144c1:
>>>
>>>   i386: Add EPYC-IBPB CPU model (2018-01-17 23:54:39 -0200)
>>>
>>> ----------------------------------------------------------------
>>> x86 queue, 2018-01-17
>>>
>>> Highlight: new CPU models that expose CPU features that guests
>>> can use to mitigate CVE-2017-5715 (Spectre variant #2).
>>>
>>
>> Applied, thanks.
>>
>> -- PMM
>>
> 
> Hi,
> I was kind of clinging to [1] so far and had the expectation that all
> those would be wrapped up in 2.11.1 once ready.
> I see that the s390x changes are targeted to qemu-stable (well to
> admit I suggested so referring the article above).
> So I'd expected to see this series to show up on qemu-stable as well
> but haven't seen it so far.
> 
> Therefore I wanted to ask if there was a change of plans in that
> regard or if it needs just a few days more to see (part of) this
> series on qemu-stable and on its way into 2.11.1?
> 
> [1]: https://www.qemu.org/2018/01/04/spectre/

Adding Michael,

Yes, I think it makes sense to have the guest enablement for the spectre 
mitigations available in 2.11.1 for all architectures that provide it. 
(this queue for x86, Connies pending S390 patches, whatever Power
and arm will do).

Not sure about a 2.10.3?
