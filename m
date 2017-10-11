Received: from eggs.gnu.org ([2001:4830:134:3::10]:51877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e2GnS-0006DX-5t
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 09:11:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e2GnN-0005Wo-4o
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 09:11:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1e2GnM-0005Vo-UD
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 09:11:33 -0400
References: <CAFEAcA-KNF0Q2HisqN8s0zhm1dyPxFrKri6tYNpUai_=OnAppw@mail.gmail.com>
	<96a6584b-ee29-13a2-622a-b07788ffcf79@linaro.org>
	<150765743910.11829.11218016346709035274@sif>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <156e0052-1cff-f951-0142-bc1500f67aaa@redhat.com>
Date: Wed, 11 Oct 2017 15:11:27 +0200
MIME-Version: 1.0
In-Reply-To: <150765743910.11829.11218016346709035274@sif>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] updating to a u-boot without the case-sensitive
 filename clash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: Alexander Graf <agraf@suse.de>

On 10.10.2017 19:43, Michael Roth wrote:
> Quoting Richard Henderson (2017-10-10 11:32:22)
>> On 10/10/2017 07:22 AM, Peter Maydell wrote:
>>> I can see a couple of options:
>>>  (1) wait for next u-boot release (scheduled for Nov 13, 2017),
>>>      and move to that
>>>      [downsides: would be in the middle of QEMU's own release cycle,
>>>       pretty late to fix any problems with the new version;
>>>       rather a big change to put into stable]
>>>  (2) move to u-boot current head-of-unstable
>>>      [downsides: would mean running some random git commit version,
>>>       also not really very suitable for stable]
>>
>> It's always difficult to sync the release cycles of disjoint projects.
>>
>> You had nothing particularly good to say about using a non-released u-boot, so
>> really you have two options:
>>
>>   (a) Update u-boot for 2.12 and not 2.11,
>>   (b) Track u-boot during its release process, noticing and reporting problems,
>>       and updating to the final release when it appears.  If you go this route,
>>       you may well have to slip our release if theirs slips.
>>
>> The second option is not particularly appealing.
>>
>> Is there another possibility in which we split the packaging to cope with the
>> current u-boot?  Normally no one builds u-boot; we simply package it for
>> licensing.  If the packaging were in two parts, one could unpack the first part
>> only and not encounter the problem.
> 
> Would something like this be sufficient?
> 
> diff --git a/scripts/make-release b/scripts/make-release
> index fa6323fda8..96c21e7a74 100755
> --- a/scripts/make-release
> +++ b/scripts/make-release
> @@ -20,6 +20,7 @@ git checkout "v${version}"
>  git submodule update --init
>  (cd roms/seabios && git describe --tags --long --dirty > .version)
>  rm -rf .git roms/*/.git dtc/.git pixman/.git
> +tar cfj roms/u-boot.tar.bz2 roms/u-boot && rm -rf roms/u-boot

FWIW, that sounds like a good idea to me, too.

 Thomas
