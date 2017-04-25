Received: from eggs.gnu.org ([2001:4830:134:3::10]:51943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d33po-0004zR-Qe
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 13:01:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d33pl-0004Xc-Qp
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 13:01:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d33pl-0004XI-KF
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 13:01:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 21E6E25BF6F
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 17:01:00 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <486c3746-e254-677d-7709-54670eafa6b0@redhat.com> (Laurent
	Vivier's message of "Tue, 25 Apr 2017 17:21:13 +0200")
References: <20170425102446.4008-1-quintela@redhat.com>
	<20170425102446.4008-7-quintela@redhat.com>
	<486c3746-e254-677d-7709-54670eafa6b0@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 25 Apr 2017 19:00:57 +0200
Message-ID: <87inlsmng6.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 6/6] migration: Pass Error ** argument to
 {save, load}_vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, peterx@redhat.com

Laurent Vivier <lvivier@redhat.com> wrote:
> On 25/04/2017 12:24, Juan Quintela wrote:
>> This way we use the "normal" way of printing errors for hmp commands.
>> 
>> --
>> Paolo suggestion
>
> "Suggested-by" tag?

Thanks.
>>  {
>> +    Error *err = NULL;
>> +
>>      if (replay_snapshot) {
>>          if (replay_mode == REPLAY_MODE_RECORD) {
>> -            if (save_vmstate(replay_snapshot) != 0) {
>> +            if (save_vmstate(replay_snapshot, &err) != 0) {
>>                  error_report("Could not create snapshot for icount record");
>>                  exit(1);
>>              }
>>          } else if (replay_mode == REPLAY_MODE_PLAY) {
>> -            if (load_vmstate(replay_snapshot) != 0) {
>> +            if (load_vmstate(replay_snapshot, &err) != 0) {
>>                  error_report("Could not load snapshot for icount replay");
>>                  exit(1);
>>              }
>
> You can use "&error_fatal" in these cases.

I was very happy with your suggestion.  But then I realized that if I
use error_fatal, I would lost the error_report() messages, right?

Later, Juan.
