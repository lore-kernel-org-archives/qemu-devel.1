Received: from eggs.gnu.org ([2001:4830:134:3::10]:49443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dX0XA-00051x-Le
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 03:33:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dX0X7-0007FE-IA
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 03:33:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dX0X7-0007F1-8J
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 03:33:33 -0400
References: <1499964378-24344-1-git-send-email-mst@redhat.com>
	<c491c6ee-67ed-e7a0-4294-b128f63d6841@redhat.com>
	<415ee774-cab4-f48a-c081-c2158de35b50@redhat.com>
	<20170714173714-mutt-send-email-mst@kernel.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <35fc2797-a83e-c9bd-639a-02dbcc5b1663@redhat.com>
Date: Mon, 17 Jul 2017 09:33:25 +0200
MIME-Version: 1.0
In-Reply-To: <20170714173714-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tests: switch pxe and vm gen id tests to
 use kvm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Ben Warren <ben@skyportsystems.com>, Peter Maydell <peter.maydell@linaro.org>

On 14.07.2017 16:45, Michael S. Tsirkin wrote:
> On Fri, Jul 14, 2017 at 07:59:54AM +0200, Thomas Huth wrote:
>> On 13.07.2017 19:00, Paolo Bonzini wrote:
>>> On 13/07/2017 18:47, Michael S. Tsirkin wrote:
>>>> Speed up tests on host systems with kvm support.
[...]
>>>> diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
>>>> index 0556ba2..6477dcc 100644
>>>> --- a/tests/vmgenid-test.c
>>>> +++ b/tests/vmgenid-test.c
>>>> @@ -132,7 +132,7 @@ static char disk[] = "tests/vmgenid-test-disk-XXXXXX";
>>>>  
>>>>  static char *guid_cmd_strdup(const char *guid)
>>>>  {
>>>> -    return g_strdup_printf("-machine accel=tcg "
>>>> +    return g_strdup_printf("-machine accel=kvm:tcg "
>>>>                             "-device vmgenid,id=testvgid,guid=%s "
>>>>                             "-drive id=hd0,if=none,file=%s,format=raw "
>>>>                             "-device ide-hd,drive=hd0 ",
>>>
>>> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
>>
>> NACK.
> 
> As a rule, don't send nacks please. Skip directly to the technical
> argument. Nacks add very little to the discussion and tend to scare away
> contributors.

I hope I won't scare *you* away that easily ;-)
But ok, I got the message, and will try to remember it.

>> It's not that simple. If you do it like this, you then suddenly get
>> these ugly '"kvm" accelerator not found' messages during "make check"
>> which we really should avoid.
>>
>> Laurent suggested some better ideas a couple of months ago, but I think
>> the common sense was rather "unit tests should always use TCG" at that
>> point in time:
>>
>>  https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg00400.html
> 
> Looks good. This was never posted as a patch. Would you or him care
> to test it and re-post? I'll include it with my patch.

That URL points to Paolo's "we should always only use TCG mail" ... I
guess you are rather referring to the other URL below?

 Thomas


>> Well, now that we've got the "--disable-tcg" configure option, we should
>> maybe start to reconsider that ;-)
>>
>> So I'm fine with the patch if you also include Laurent's patch to shut
>> up the error message:
>>
>>  https://lists.gnu.org/archive/html/qemu-devel/2016-10/msg00395.html
>>
>>  Thomas
