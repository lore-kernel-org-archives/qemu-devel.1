Received: from eggs.gnu.org ([2001:4830:134:3::10]:57990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0jtk-0002ae-6s
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 03:19:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0jth-0008Pr-2K
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 03:19:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59952)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d0jtg-0008Pf-T5
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 03:19:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C600B72AE4
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 07:19:27 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <7aedc2da-c0de-a99a-eb8d-16fbe9cba8f3@redhat.com> (Paolo
	Bonzini's message of "Tue, 18 Apr 2017 11:46:33 +0200")
References: <20170417200041.2451-1-quintela@redhat.com>
	<20170417200041.2451-20-quintela@redhat.com>
	<c7f9792c-1e78-b7b9-c5cc-04b650b82820@redhat.com>
	<7aedc2da-c0de-a99a-eb8d-16fbe9cba8f3@redhat.com>
Reply-To: quintela@redhat.com
Date: Wed, 19 Apr 2017 09:19:25 +0200
Message-ID: <877f2ghnk2.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 19/19] monitor: remove monitor parameter
 from save_vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 18/04/2017 11:44, Paolo Bonzini wrote:
>> 
>> 
>> On 17/04/2017 22:00, Juan Quintela wrote:
>>> load_vmstate() already use error_report, so be consistent.
>> 
>> Better: make both return Error* via an Error** parameter, and add
>> 
>>     hmp_handle_error(mon, &err);
>> 
>> to hmp_savevm and error_report_err(err) on the loading side.
>
> Not really, loadvm is also a monitor command (I was confusing it with
> -incoming).  So it can use hmp_handle_error too.

I think that I *understood* (famous last words) how the error should be
done on hmp commands.  We will see on next respin.

Later, Juan.
