Received: from eggs.gnu.org ([2001:4830:134:3::10]:33492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e1xMt-00029w-Kg
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:26:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e1xMq-0000at-HQ
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:26:55 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:55339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e1xMq-0000Xr-A8
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 12:26:52 -0400
Received: by mail-wm0-f52.google.com with SMTP id u138so7010550wmu.4
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 09:26:48 -0700 (PDT)
References: <CAFEAcA-zUTfLOBkOeLc4e1Ok0dnKD=hWsdeR47125MhMnwV7UA@mail.gmail.com>
	<20171010161008.GM30015@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7c9386e1-b257-29bd-a344-d36574850b70@redhat.com>
Date: Tue, 10 Oct 2017 18:26:45 +0200
MIME-Version: 1.0
In-Reply-To: <20171010161008.GM30015@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] proposed schedule for 2.11 release
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 10/10/2017 18:10, Daniel P. Berrange wrote:
> On Tue, Oct 10, 2017 at 03:07:26PM +0100, Peter Maydell wrote:
>> OK, here's a strawman proposal for the 2.11 release cycle,
>> based on aiming for a 5 Dec release date and working backwards
>> with the same cadence as 2.10.
>>
>> 2017-10-31 Soft freeze -- all feature changes must already be in a
>>            pull request that's been sent to the mailing list
>> 2017-11-07 Hard freeze, tag rc0
>> 2017-11-14 Tag rc1
>> 2017-11-21 Tag rc2
>> 2017-11-28 Tag rc3
>> 2017-12-05 Release (or rc4 if we need it)
>> 2017-12-12 Release if we needed an rc4
>>
>> That makes softfreeze in 3 weeks time. I'd rather not push
>> the times back any further because we end up in serious
>> risk of running into the christmas holiday period.
> 
> Soft freeze date is not great from a KVM Forum timing POV - the 31st is
> likely to be a travel day for most of the Red Hat devs.

Might as well have soft freeze on Oct 24 (and keep hard freeze on Nov
7)...  Non-maintainers posting patches on the Oct 24-31 week probably
wouldn't have them included in 2.11 anyway.

Paolo

> That said I don't see a much nicer alternative, since giving two weeks
> grace before xmas is good, to allow time for slippage in worst case
> scenarios.
> 
> I guess, it in effect just means that most soft freeze work will want to
> be front loaded in the next 2 weeks before KVM Forum travel starts impacting
> working time.
> 
> Regards,
> Daniel
> 
