Received: from eggs.gnu.org ([2001:4830:134:3::10]:42017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dfROy-0007vu-Km
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:52:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dfROx-0002V7-De
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:52:00 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dfROx-0002UP-59
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:51:59 -0400
Received: by mail-wm0-x244.google.com with SMTP id q189so6909777wmd.0
	for <qemu-devel@nongnu.org>; Wed, 09 Aug 2017 06:51:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170809131032.GH24723@redhat.com>
References: <CAJSP0QVrCm6TfgU0dsXbudaW3gmGo0YQTTWbNypx6st6mKcSKA@mail.gmail.com>
	<20170809131032.GH24723@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 9 Aug 2017 14:51:57 +0100
Message-ID: <CAJSP0QUMo4FocU0iRV2ti3eWDJLYXGcyur0-Nd4uG+-qnad96A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Making QEMU build with Python 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Ross Burton <ross@burtonini.com>

On Wed, Aug 9, 2017 at 2:10 PM, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Wed, Aug 09, 2017 at 11:16:58AM +0100, Stefan Hajnoczi wrote:
>> Ross created a bug to track Python 3 support:
>>
>>   https://bugs.launchpad.net/qemu/+bug/1708462
>>
>> Currently most Python code in QEMU is for Python 2.6+ only.  There
>> have only been a few patches adding Python 3 support to certain
>> scripts so far.
>>
>> In this email I want to highlight the most important scripts that need
>> Python 3 support.  Volunteers are welcome!
>>
>> Python scripts needed to build QEMU are the highest priority.  They
>> are invoked by ./configure or make.  I've identified the following:
>>
>> scripts/signrom.py
>> scripts/qapi*.py
>> scripts/modules/module_block.py
>> scripts/tracetool*
>
>> I have tracetool on my todo list and hope to add Python 3 support in QEMU 2.11.
>
> AFAICT tracetool seems to already work - i hacked rules.mak to
> run tracetool via python3 and nothing obvious broke

Nice, thanks for checking!  I'll test all the tracetool backends and
audit the code for 2.11.

Stefan
