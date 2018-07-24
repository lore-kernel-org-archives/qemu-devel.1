Received: from eggs.gnu.org ([2001:4830:134:3::10]:56715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fhyZN-0000Iu-Ci
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 10:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fhyZK-00029z-PS
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 10:45:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56460 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fhyZK-00029n-Ha
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 10:45:42 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 182DE87A7A
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 14:45:42 +0000 (UTC)
References: <20180724120003.27053-1-pbonzini@redhat.com>
	<20180724144412.GC2374@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fa44f533-a24e-943e-c8dc-63b33c9e11e1@redhat.com>
Date: Tue, 24 Jul 2018 16:45:39 +0200
MIME-Version: 1.0
In-Reply-To: <20180724144412.GC2374@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] i386: do not migrate MSR_SMI_COUNT on
 machine types <2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org

On 24/07/2018 16:44, Dr. David Alan Gilbert wrote:
>> +    DEFINE_PROP_BOOL("x-migrate-smi-count", X86CPU, migrate_smi_count,
>> +                     false),
> Shouldn't that be true?
> (and then turned off in the compat)

Hrm of course. :)

Paolo
