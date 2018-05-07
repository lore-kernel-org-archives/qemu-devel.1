Received: from eggs.gnu.org ([2001:4830:134:3::10]:56674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fFdsd-0007Qt-30
	for qemu-devel@nongnu.org; Mon, 07 May 2018 07:00:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fFdsY-0004jr-Vk
	for qemu-devel@nongnu.org; Mon, 07 May 2018 07:00:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49982 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fFdsY-0004gb-Of
	for qemu-devel@nongnu.org; Mon, 07 May 2018 07:00:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A92DA738E0
	for <qemu-devel@nongnu.org>; Mon,  7 May 2018 11:00:21 +0000 (UTC)
References: <1525453270-23074-1-git-send-email-thuth@redhat.com>
	<f7756c7c-338a-a719-7135-aa7a53a62c4c@redhat.com>
	<87wowgyqj8.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9bbc2a49-4819-35fe-d164-ef88aa2494c2@redhat.com>
Date: Mon, 7 May 2018 13:00:15 +0200
MIME-Version: 1.0
In-Reply-To: <87wowgyqj8.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/5] Removal of deprecated -no-kvm*
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On 07/05/2018 07:37, Markus Armbruster wrote:
>> I'm not that sure anymore about -no-kvm.  It can come in handy for
>> distros (*cough* RHEL *cough) that only ship a qemu-kvm binary with
>> default accelerator "-machine accel=kvm:tcg".
>>
>> Yeah, "-accel tcg" is only a few characters later, but it is a
>> relatively recent addition.
>
> 2012 is "relatively recent" in the alternate RHEL universe, perhaps :)

Well, that's for "-machine accel=tcg" which is quite a mouthful.

"-accel tcg" was added in 2.9, about a year ago (commit 8d4e9146b3,
"tcg: add options for enabling MTTCG", 2017-02-24).

Paolo

> 
> Author: Jan Kiszka <jan.kiszka@siemens.com>
> Date:   Fri Oct 5 14:51:45 2012 -0300
> 
>     Emulate qemu-kvms -no-kvm option
>     
>     Releases of qemu-kvm will be interrupted at qemu 1.3.0.
>     Users should switch to plain qemu releases.
>     To avoid breaking scenarios which are setup with command line
>     options specific to qemu-kvm, port these switches from qemu-kvm
>     to qemu.git.
>     
>     Port -no-kvm option.
>     
>     Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
