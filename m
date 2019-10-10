Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731C5C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:39:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47469206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 12:39:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47469206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIXiw-00040o-1j
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 08:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53729)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iIX4I-0006R5-4L
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:57:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iIX4G-0004Gz-K0
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:57:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44486)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iIX4G-0004GW-Bg
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:57:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 928FE18CCEE2;
 Thu, 10 Oct 2019 11:57:15 +0000 (UTC)
Received: from thuth.remote.csb (dhcp-200-228.str.redhat.com [10.33.200.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 627A55D6A5;
 Thu, 10 Oct 2019 11:57:11 +0000 (UTC)
Subject: Re: [PATCH 5/5] travis.yml: Compile on arm64, too
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20191009170701.14756-1-thuth@redhat.com>
 <20191009170701.14756-6-thuth@redhat.com> <20191010105808.GH28562@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; prefer-encrypt=mutual; keydata=
 mQINBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABtB5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT6JAjgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDuQIN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABiQIfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
Organization: Red Hat
Message-ID: <11a2be24-f177-8c55-b0fc-3945d023b877@redhat.com>
Date: Thu, 10 Oct 2019 13:57:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191010105808.GH28562@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Thu, 10 Oct 2019 11:57:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/10/2019 12.58, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Oct 09, 2019 at 07:07:01PM +0200, Thomas Huth wrote:
>> Travis now features an arm64 build host, so let's check compilation
>> there, too.
>>
>> Unfortunately, there are some quirks:
>> - block/ssh.c does not compile properly in this environment, so we hav=
e
>>   to use --disable-libssh until that problem is fixed.
>> - test-util-filemonitor fails, so we can not run the unit tests there
>=20
> Do you have any more info on this failure ?
>=20
> Running tests with FILEMONITOR_DEBUG=3D1 env variable set will make
> it print more info

Here you go:

https://travis-ci.com/huth/qemu/jobs/244168910#L5775

Quoting:

"
Add watch /tmp/test-util-filemonitor-PH0B9Z (null)
Watch ID 100000000
Add watch /tmp/test-util-filemonitor-PH0B9Z one.txt
Watch ID 100000001
Add watch /tmp/test-util-filemonitor-PH0B9Z two.txt
Watch ID 100000002
Create /tmp/test-util-filemonitor-PH0B9Z/one.txt
Event id=3D100000000 event=3D0 file=3Done.txt
Queue event id 100000000 event 0 file one.txt
Queue event id 100000001 event 0 file one.txt
Event id=3D100000001 event=3D0 file=3Done.txt
Create /tmp/test-util-filemonitor-PH0B9Z/two.txt
Queue event id 100000000 event 0 file two.txt
Queue event id 100000002 event 0 file two.txt
Event id=3D100000000 event=3D0 file=3Dtwo.txt
Event id=3D100000002 event=3D0 file=3Dtwo.txt
Create /tmp/test-util-filemonitor-PH0B9Z/three.txt
Queue event id 100000000 event 0 file three.txt
Event id=3D100000000 event=3D0 file=3Dthree.txt
Unlink /tmp/test-util-filemonitor-PH0B9Z/three.txt
Queue event id 100000000 event 2 file three.txt
Event id=3D100000000 event=3D2 file=3Dthree.txt
Rename /tmp/test-util-filemonitor-PH0B9Z/one.txt ->
/tmp/test-util-filemonitor-PH0B9Z/two.txt
Queue event id 100000000 event 2 file one.txt
Queue event id 100000001 event 2 file one.txt
Queue event id 100000000 event 0 file two.txt
Queue event id 100000002 event 0 file two.txt
Event id=3D100000000 event=3D2 file=3Done.txt
Event id=3D100000001 event=3D2 file=3Done.txt
Event id=3D100000000 event=3D0 file=3Dtwo.txt
Event id=3D100000002 event=3D0 file=3Dtwo.txt
Append /tmp/test-util-filemonitor-PH0B9Z/two.txt
Queue event id 100000000 event 1 file two.txt
Queue event id 100000002 event 1 file two.txt
Event id=3D100000000 event=3D1 file=3Dtwo.txt
Event id=3D100000002 event=3D1 file=3Dtwo.txt
Touch /tmp/test-util-filemonitor-PH0B9Z/two.txt
Event id=3D100000000 event=3D3 file=3Dtwo.txt
Queue event id 100000000 event 3 file two.txt
Queue event id 100000002 event 3 file two.txt
Event id=3D100000002 event=3D3 file=3Dtwo.txt
Del watch /tmp/test-util-filemonitor-PH0B9Z 100000001
Add watch /tmp/test-util-filemonitor-PH0B9Z one.txt
Watch ID 100000003
Create /tmp/test-util-filemonitor-PH0B9Z/one.txt
Queue event id 100000000 event 0 file one.txt
Event id=3D100000000 event=3D0 file=3Done.txt
Queue event id 100000003 event 0 file one.txt
Event id=3D100000003 event=3D0 file=3Done.txt
Del watch /tmp/test-util-filemonitor-PH0B9Z 100000003
Unlink /tmp/test-util-filemonitor-PH0B9Z/one.txt
Queue event id 100000000 event 2 file one.txt
Event id=3D100000000 event=3D2 file=3Done.txt
Mkdir /tmp/test-util-filemonitor-PH0B9Z/fish
Queue event id 100000000 event 0 file fish
Event id=3D100000000 event=3D0 file=3Dfish
Add watch /tmp/test-util-filemonitor-PH0B9Z fish/
Watch ID 200000000
Add watch /tmp/test-util-filemonitor-PH0B9Z fish/one.txt
Watch ID 200000001
Create /tmp/test-util-filemonitor-PH0B9Z/fish/one.txt
Queue event id 200000000 event 0 file one.txt
Queue event id 200000001 event 0 file one.txt
Event id=3D200000000 event=3D0 file=3Done.txt
Event id=3D200000001 event=3D0 file=3Done.txt
Del watch /tmp/test-util-filemonitor-PH0B9Z 200000001
Rename /tmp/test-util-filemonitor-PH0B9Z/fish/one.txt ->
/tmp/test-util-filemonitor-PH0B9Z/two.txt
Queue event id 200000000 event 2 file one.txt
Event id=3D200000000 event=3D2 file=3Done.txt
Queue event id 100000000 event 0 file two.txt
Event id=3D100000000 event=3D0 file=3Dtwo.txt
Event id=3D100000002 event=3D0 file=3Dtwo.txt
Queue event id 100000002 event 0 file two.txt
Rmdir /tmp/test-util-filemonitor-PH0B9Z/fish
Queue event id 100000000 event 2 file fish
Event id=3D200000000 event=3D4 file=3D
Missing event watch id 200000000 event 4 file
**
ERROR:tests/test-util-filemonitor.c:690:test_file_monitor_events:
assertion failed: (err =3D=3D 0)
ERROR - Bail out!
ERROR:tests/test-util-filemonitor.c:690:test_file_monitor_events:
assertion failed: (err =3D=3D 0)
Aborted
/home/travis/build/huth/qemu/tests/Makefile.include:904: recipe for
target 'check-unit' failed
make: *** [check-unit] Error 1
"

 Thomas

