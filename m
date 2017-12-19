Received: from eggs.gnu.org ([2001:4830:134:3::10]:35996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eRHKt-0004iN-8z
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 07:49:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eRHKq-0001a6-N6
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 07:49:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eRHKq-0001ZR-D8
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 07:49:28 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6D2AE7E436
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 12:49:27 +0000 (UTC)
References: <1513619065-31722-1-git-send-email-thuth@redhat.com>
	<a2451ec3-0234-f4db-039c-a37ba1d5a571@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4c62b984-62ac-88fe-638d-6ff6a2ae42eb@redhat.com>
Date: Tue, 19 Dec 2017 13:49:25 +0100
MIME-Version: 1.0
In-Reply-To: <a2451ec3-0234-f4db-039c-a37ba1d5a571@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Remove legacy -no-kvm-pit option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 19.12.2017 11:56, Paolo Bonzini wrote:
> On 18/12/2017 18:44, Thomas Huth wrote:
>> It's only printing a warning since QEMU v1.3.0, so nobody should use
>> this anymore today. Let's get rid of this now.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  qemu-doc.texi   | 5 -----
>>  qemu-options.hx | 3 ---
>>  vl.c            | 4 ----
>>  3 files changed, 12 deletions(-)
>>
>> diff --git a/qemu-doc.texi b/qemu-doc.texi
>> index 14d818d..d9861b3 100644
>> --- a/qemu-doc.texi
>> +++ b/qemu-doc.texi
>> @@ -2396,11 +2396,6 @@ synonym for setting ``-global kvm-pit.lost_tick_policy=discard''.
>>  The ``-no-kvm-irqchip'' argument is now a synonym for
>>  setting ``-machine kernel_irqchip=off''.
>>  
>> -@subsection -no-kvm-pit (since 1.3.0)
>> -
>> -The ``-no-kvm-pit'' argument is ignored. It is no longer
>> -possible to disable the KVM PIT directly.
>> -
>>  @subsection -no-kvm (since 1.3.0)
>>  
>>  The ``-no-kvm'' argument is now a synonym for setting
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index fe0c292..aa0e849 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -4139,9 +4139,6 @@ HXCOMM Deprecated by kvm-pit driver properties
>>  DEF("no-kvm-pit-reinjection", 0, QEMU_OPTION_no_kvm_pit_reinjection,
>>      "", QEMU_ARCH_I386)
>>  
>> -HXCOMM Deprecated (ignored)
>> -DEF("no-kvm-pit", 0, QEMU_OPTION_no_kvm_pit, "", QEMU_ARCH_I386)
>> -
>>  HXCOMM Deprecated by -machine kernel_irqchip=on|off property
>>  DEF("no-kvm-irqchip", 0, QEMU_OPTION_no_kvm_irqchip, "", QEMU_ARCH_I386)
>>  
>> diff --git a/vl.c b/vl.c
>> index fc8bd93..2644400 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -3818,10 +3818,6 @@ int main(int argc, char **argv, char **envp)
>>                  olist = qemu_find_opts("machine");
>>                  qemu_opts_parse_noisily(olist, "accel=tcg", false);
>>                  break;
>> -            case QEMU_OPTION_no_kvm_pit: {
>> -                warn_report("ignoring deprecated option");
>> -                break;
>> -            }
>>              case QEMU_OPTION_no_kvm_pit_reinjection: {
>>                  static GlobalProperty kvm_pit_lost_tick_policy = {
>>                      .driver   = "kvm-pit",
>>
> 
> Queued, thanks.  Please create the 2.12 changelog page and add it to the
> incompatible changes section.

Ok, I'll do that as soon as this patch hits the master branch.

 Thomas
