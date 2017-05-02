Received: from eggs.gnu.org ([2001:4830:134:3::10]:49690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1d5VM9-0005oY-IZ
	for qemu-devel@nongnu.org; Tue, 02 May 2017 06:48:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1d5VM6-0000VP-HO
	for qemu-devel@nongnu.org; Tue, 02 May 2017 06:48:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47494
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1d5VM6-0000VH-Aq
	for qemu-devel@nongnu.org; Tue, 02 May 2017 06:48:30 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v42AXw3e077611
	for <qemu-devel@nongnu.org>; Tue, 2 May 2017 06:48:29 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a6hy1m6kf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 06:48:29 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 2 May 2017 04:48:28 -0600
References: <1493719600-30853-1-git-send-email-thuth@redhat.com>
	<52fc3efd-55a7-af2d-ce8c-9b4565dfe6dc@de.ibm.com>
	<f2c35612-d2f5-0570-7cfa-66538882894e@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 2 May 2017 12:48:23 +0200
MIME-Version: 1.0
In-Reply-To: <f2c35612-d2f5-0570-7cfa-66538882894e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <df5e01ee-a97f-7e28-9f95-840654bf48a5@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] Deprecate '-enable-kvm' and '-enable-hax'
 in favour of '-accel'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vincent Palatin <vpalatin@chromium.org>

On 05/02/2017 12:37 PM, Thomas Huth wrote:
> On 02.05.2017 12:32, Christian Borntraeger wrote:
>> On 05/02/2017 12:06 PM, Thomas Huth wrote:
>>> The '-enable-...' option do not make too much sense: They do not
>>> allow additional parameters, using '-accel xxx' is shorter than
>>> '-enable-xxx' and we're also inconsistent here, since there is
>>> no '-enable-xen' option available. So let's try to convince the
>>> users to use '-accel xxx' instead.
>>
>> google has 36000 hits for "--enable-kvm" and 18000 hits for "--accel kvm"
>> So I assume this will affect a lot of setups for only a very small benefit.
> 
> I'm aware of the fact that likely a lot of users are still using
> -enable-kvm, and I did not mean that we should remove it soon yet. But
> IMHO we should start now to inform the users that they should slowly
> switch to the better option "-accel" instead, so that we could maybe
> remove this "-enable-xxx" stuff sometime in the distant future (let's
> say QEMU v4.0?).

I come from the Linux side, where "breaking a working setup" will result in
an angry Linus. We certainly have not such strict rules here and we could 
base the decision on the question "how expensive is the maintenance
of this option?". I think marking it as "legacy option" is fine, but I doubt
that removing it will make qemu maintenance cheaper. So my preferred variant
is
- have it marked in the docs as "legacy"
- no error_report as it might break some setups (since error_report might write
to the monitor)
- never remove the option unless it turns out to be a burden

But its certainly not my call to make.
