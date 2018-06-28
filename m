Received: from eggs.gnu.org ([2001:4830:134:3::10]:47943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYR2t-00039I-T4
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 03:08:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYR2o-0001tH-Uc
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 03:08:47 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fYR2o-0001sx-OJ
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 03:08:42 -0400
Received: by mail-wr0-f193.google.com with SMTP id a12-v6so4332229wro.1
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 00:08:42 -0700 (PDT)
References: <20180626154028.11133-1-pbonzini@redhat.com>
	<20180626154028.11133-5-pbonzini@redhat.com>
	<6f643a0b-71f4-4034-d8ec-c5a0a2f84ba6@redhat.com>
	<8c63167d-c5e4-5fe4-ddae-5c69c7fd46e0@redhat.com>
	<7c40a4b2-1a4e-8ace-a58f-a6419ffd6df1@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ce8e690d-82c0-882d-07ec-b5d1b97fc9f0@redhat.com>
Date: Thu, 28 Jun 2018 09:08:39 +0200
MIME-Version: 1.0
In-Reply-To: <7c40a4b2-1a4e-8ace-a58f-a6419ffd6df1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 4/5] pr-manager: add query-pr-managers QMP
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>, qemu-devel@nongnu.org

On 28/06/2018 09:05, Michal Prívozník wrote:
>> qemu-pr-helper anyway does something only when a guests sends it a PR
>> command - and with libvirt's per-guest model, that would (hopefully)
>> mean that the only case that remains is when someone manually kills the
>> qemu-pr-helper process.  In that case there's a certain amount of PEBKAC
>> involved... :)
>
> Unless an assert() is triggered ;-)

Indeed, but that should still happen "when a guest sends it a PR
command".  The problematic case would only arise if qemu-pr-helper
crashes between the last time QEMU sent a command, and the time libvirt
sends query-pr-managers.

> But since you merged my suggested changes in 5/5 libvirt can catch the
> event pretty soon, so in my testing qemu was still left with 3-4
> connection retries which is plenty.

Good, thanks.

Paolo
