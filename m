Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B40C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 19:49:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89A1C20862
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 19:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A1C20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAJTF-00063c-Bt
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 15:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iAJQa-0003vF-Dv
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 15:46:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iAJQY-0005jI-4D
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 15:46:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33418)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iAJQT-0005iR-Fw; Tue, 17 Sep 2019 15:46:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A1BDB3082145;
 Tue, 17 Sep 2019 19:46:12 +0000 (UTC)
Received: from [10.18.17.165] (dhcp-17-165.bos.redhat.com [10.18.17.165])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C0AB65D6A5;
 Tue, 17 Sep 2019 19:46:11 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20190912001633.11372-1-jsnow@redhat.com>
 <20190912001633.11372-5-jsnow@redhat.com>
 <28f04d86-935f-bc7a-2a38-f87c6843e221@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 mQINBFTKefwBEAChvwqYC6saTzawbih87LqBYq0d5A8jXYXaiFMV/EvMSDqqY4EY6whXliNO
 IYzhgrPEe7ZmPxbCSe4iMykjhwMh5byIHDoPGDU+FsQty2KXuoxto+ZdrP9gymAgmyqdk3aV
 vzzmCa3cOppcqKvA0Kqr10UeX/z4OMVV390V+DVWUvzXpda45/Sxup57pk+hyY52wxxjIqef
 rj8u5BN93s5uCVTus0oiVA6W+iXYzTvVDStMFVqnTxSxlpZoH5RGKvmoWV3uutByQyBPHW2U
 1Y6n6iEZ9MlP3hcDqlo0S8jeP03HaD4gOqCuqLceWF5+2WyHzNfylpNMFVi+Hp0H/nSDtCvQ
 ua7j+6Pt7q5rvqgHvRipkDDVsjqwasuNc3wyoHexrBeLU/iJBuDld5iLy+dHXoYMB3HmjMxj
 3K5/8XhGrDx6BDFeO3HIpi3u2z1jniB7RtyVEtdupED6lqsDj0oSz9NxaOFZrS3Jf6z/kHIf
 h42mM9Sx7+s4c07N2LieUxcfqhFTaa/voRibF4cmkBVUhOD1AKXNfhEsTvmcz9NbUchCkcvA
 T9119CrsxfVsE7bXiGvdXnzyGLXdsoosjzwacKdOrVaDmN3Uy+SHiQXo6TlkSdV0XH2PUxTM
 LsBFIO9qXO43Ai6J6iPAP/01l8fuZfpJE0/L/c25yyaND7xA3wARAQABtCpKb2huIFNub3cg
 KEpvaG4gSHVzdG9uKSA8anNub3dAcmVkaGF0LmNvbT6JAlQEEwECAD4CGwMCHgECF4AFCwkI
 BwMFFQoJCAsFFgIDAQAWIQT665cRoSz0dYEvGPKIqQZNGDVh6wUCXF392gUJC1Xq3gAKCRCI
 qQZNGDVh6558D/9pM4pu4njX5aT6uUW3vAmbWLF1jfPxiTQgSHAnm9EBMZED/fsvkzj97clo
 LN7JKmbYZNgJmR01A7flG45V4iOR/249qAfaVuD+ZzZi1R4jFzr13WS+IEdn0hYp9ITndb7R
 ezW+HGu6/rP2PnfmDnNowgJu6Dp6IUEabq8SXXwGHXZPuMIrsXJxUdKJdGnh1o2u7271yNO7
 J9PEMuMDsgjsdnaGtv7aQ9CECtXvBleAc06pLW2HU10r5wQyBMZGITemJdBhhdzGmbHAL0M6
 vKi/bafHRWqfMqOAdDkv3Jg4arl2NCG/uNateR1z5e529+UlB4XVAQT+f5T/YyI65DFTY940
 il3aZhA8u788jZEPMXmt94u7uPZbEYp7V0jt68SrTaOgO7NaXsboXFjwEa42Ug5lB5d5/Qdp
 1AITUv0NJ51kKwhHL1dEagGeloIsGVQILmpS0MLdtitBHqZLsnJkRvtMaxo47giyBlv2ewmq
 tIGTlVLxHx9xkc9aVepOuiGlZaZB72c9AvZs9rKaAjgU2UfJHlB/Hr4uSk/1EY0IgMv4vnsG
 1sA5gvS7A4T4euu0PqHtn2sZEWDrk5RDbw0yIb53JYdXboLFmFXKzVASfKh2ZVeXRBlQQSJi
 3PBR1GzzqORlfryby7mkY857xzCI2NkIkD2eq+HhzFTfFOTdGrkCDQRUynn8ARAAwbhP45BE
 d/zAMBPV2dk2WwIwKRSKULElP3kXpcuiDWYQob3UODUUqClO+3aXVRndaNmZX9WbzGYexVo3
 5j+CVBCGr3DlU8AL9pp3KQ3SJihWcDed1LSmUf8tS+10d6mdGxDqgnd/OWU214isvhgWZtZG
 MM/Xj7cx5pERIiP+jqu7PT1cibcfcEKhPjYdyV1QnLtKNGrTg/UMKaL+qkWBUI/8uBoa0HLs
 NH63bXsRtNAG8w6qG7iiueYZUIXKc4IHINUguqYQJVdSe+u8b2N5XNhDSEUhdlqFYraJvX6d
 TjxMTW5lzVG2KjztfErRNSUmu2gezbw1/CV0ztniOKDA7mkQi6UIUDRh4LxRm5mflfKiCyDQ
 L6P/jxHBxFv+sIgjuLrfNhIC1p3z9rvCh+idAVJgtHtYl8p6GAVrF+4xQV2zZH45tgmHo2+S
 JsLPjXZtWVsWANpepXnesyabWtNAV4qQB7/SfC77zZwsVX0OOY2Qc+iohmXo8U7DgXVDgl/R
 /5Qgfnlv0/3rOdMt6ZPy5LJr8D9LJmcP0RvX98jyoBOf06Q9QtEwJsNLCOCo2LKNL71DNjZr
 nXEwjUH66CXiRXDbDKprt71BiSTitkFhGGU88XCtrp8R9yArXPf4MN+wNYBjfT7K29gWTzxt
 9DYQIvEf69oZD5Z5qHYGp031E90AEQEAAYkCPAQYAQIAJgIbDBYhBPrrlxGhLPR1gS8Y8oip
 Bk0YNWHrBQJcXf3JBQkLVerNAAoJEIipBk0YNWHrU1AP/1FOK2SBGbyhHa5vDHuf47fgLipC
 e0/h1E0vdSonzlhPxuZoQ47FjzG9uOhqqQG6/PqtWs/FJIyz8aGG4aV+pSA/9Ko3/2ND8MSY
 ZflWs7Y8Peg08Ro01GTHFITjEUgHpTpHiT6TNcZB5aZNJ8jqCtW5UlqvXXbVeSTmO70ZiVtc
 vUJbpvSxYmzhFfZWaXIPcNcKWL1rnmnzs67lDhMLdkYVf91aml/XtyMUlfB8Iaejzud9Ht3r
 C0pA9MG57pLblX7okEshxAC0+tUdY2vANWFeX0mgqRt1GSuG9XM9H/cKP1czfUV/FgaWo/Ya
 fM4eMhUAlL/y+/AJxxumPhBXftM4yuiktp2JMezoIMJI9fmhjfWDw7+2jVrx9ze1joLakFD1
 rVAoHxVJ7ORfQ4Ni/qWbQm3T6qQkSMt4N/scNsMczibdTPxU7qtwQwIeFOOc3wEwmJ9Qe3ox
 TODQ0agXiWVj0OXYCHJ6MxTDswtyTGQW+nUHpKBgHGwUaR6d1kr/LK9+5LpOfRlK9VRfEu7D
 PGNiRkr8Abp8jHsrBqQWfUS1bAf62bq6XUel0kUCtb7qCq024aOczXYWPFpJFX+nhp4d7NeH
 Edq+wlC13sBSiSHC7T5yssJ+7JPa2ATLlSKhEvBsLe2TsSTTtFlA0nBclqhfJXzimiuge9qU
 E40lvMWBuQINBFTKimUBEADDbJ+pQ5M4QBMWkaWImRj7c598xIZ37oKM6rGaSnuB1SVb7YCr
 Ci2MTwQcrQscA2jm80O8VFqWk+/XsEp62dty47GVwSfdGje/3zv3VTH2KhOCKOq3oPP5ZXWY
 rz2d2WnTvx++o6lU7HLHDEC3NGLYNLkL1lyVxLhnhvcMxkf1EGA1DboEcMgnJrNB1pGP27ww
 cSfvdyPGseV+qZZa8kuViDga1oxmnYDxFKMGLxrClqHrRt8geQL1Wj5KFM5hFtGTK4da5lPn
 wGNd6/CINMeCT2AWZY5ySz7/tSZe5F22vPvVZGoPgQicYWdNc3ap7+7IKP86JNjmec/9RJcz
 jvrYjJdiqBVldXou72CtDydKVLVSKv8c2wBDJghYZitfYIaL8cTvQfUHRYTfo0n5KKSec8Vo
 vjDuxmdbOUBA+SkRxqmneP5OxGoZ92VusrwWCjry8HRsNdR+2T+ClDCO6Wpihu4V3CPkQwTy
 eCuMHPAT0ka5paTwLrnZIxsdfnjUa96T10vzmQgAxpbbiaLvgKJ8+76OPdDnhddyxd2ldYfw
 RkF5PEGg3mqZnYKNNBtwjvX49SAvgETQvLzQ8IKVgZS0m4z9qHHvtc1BsQnFfe+LJOFjzZr7
 CrDNJMqk1JTHYsSi2JcN3vY32WMezXSQ0TzeMK4kdnclSQyp/h23GWod5QARAQABiQRbBBgB
 AgAmAhsCFiEE+uuXEaEs9HWBLxjyiKkGTRg1YesFAlxd/coFCQtV2mQCKcFdIAQZAQIABgUC
 VMqKZQAKCRB974EGqvw5DiJoEACLmuiRq9ifvOh5DyBFwRS7gvA14DsGQngmC57EzV0EFcfM
 XVi1jX5OtwUyUe0Az5r6lHyyHDsDsIpLKBlWrYCeLpUhRR3oy181T7UNxvujGFeTkzvLAOo6
 Hs3b8Wv9ARg+7acRYkQRNY7k0GIJ6YZz149tRyRKAy/vSjsaB9Lt0NOd1wf2EQMKwRVELwJD
 y0AazGn+0PRP7Bua2YbtxaBmhBBDb2tPpwn8U9xdckB4Vlft9lcWNsC/18Gi9bpjd9FSbdH/
 sOUI+3ToWYENeoT4IP09wn6EkgWaJS3nAUN/MOycNej2i4Yhy2wDDSKyTAnVkSSSoXk+tK91
 HfqtokbDanB8daP+K5LgoiWHzjfWzsxA2jKisI4YCGjrYQzTyGOT6P6u6SEeoEx10865B/zc
 8/vN50kncdjYz2naacIDEKQNZlnGLsGkpCbfmfdi3Zg4vuWKNdWr0wGUzDUcpqW0y/lUXna+
 6uyQShX5e4JD2UPuf9WAQ9HtgSAkaDd4O1I2J41sleePzZOVB3DmYgy+ECRJJ5nw3ihdxpgc
 y/v3lfcJaqiyCv0PF+K/gSOvwhH7CbVqARmptT7yhhxqFdaYWo2Z2ksuKyoKSRMFCXQY5oac
 uTmyPIT4STFyUQFeqSCWDum/NFNoSKhmItw2Td+4VSJHShRVbg39KNFPZ7mXYAkQiKkGTRg1
 YesWJA/+PV3qDUtPNEGwjVvjQqHSbrBy94tu6gJvPHgGPtRDYvxnCaJsmgiC0pGB2KFRsnfl
 2zBNBEWF/XwsI081jQE5UO60GKmHTputChLXpVobyuc+lroG2YhknXRBAV969SLnZR4BS/1s
 Gi046gOXfaKYatve8BiZr5it5Foq3FMPDNgZMit1H9Dk8rkKFfDMRf8EGS/Z+TmyEsIf99H7
 TH3n7lco8qO81fSFwkh4pvo2kWRFYTC5vsIVQ+GqVUp+W1DZJHxX8LwWuF1AzUt4MUTtNAvy
 TXl5EgsmoY9mpNNL7ZnW65oG63nEP5KNiybvuQJzXVxR8eqzOh2Mod4nHg3PE7UCd3DvLNsn
 GXFRo44WyT/G2lArBtjpkut7bDm0i1nENABy2UgS+1QvdmgNu6aEZxdNthwRjUhuuvCCDMA4
 rCDQYyakH2tJNQgkXkeLodBKF4bHiBbuwj0E39S9wmGgg+q4OTnAO/yhQGknle7a7G5xHBwE
 i0HjnLoJP5jDcoMTabZTIazXmJz3pKM11HYJ5/ZsTIf3ZRJJKIvXJpbmcAPVwTZII6XxiJdh
 RSSX4Mvd5pL/+5WI6NTdW6DMfigTtdd85fe6PwBNVJL2ZvBfsBJZ5rxg1TOH3KLsYBqBTgW2
 glQofxhkJhDEcvjLhe3Y2BlbCWKOmvM8XS9TRt0OwUs=
Message-ID: <ac484440-14be-c1ad-b56b-997ad907f5aa@redhat.com>
Date: Tue, 17 Sep 2019 15:46:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <28f04d86-935f-bc7a-2a38-f87c6843e221@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 17 Sep 2019 19:46:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 4/4] iotests: use python logging for
 iotests.log()
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 9/17/19 7:35 AM, Vladimir Sementsov-Ogievskiy wrote:
> 12.09.2019 3:16, John Snow wrote:
>> We can turn logging on/off globally instead of per-function.
>>
>> Remove use_log from run_job, and use python logging to turn on
>> diffable output when we run through a script entry point.
>>
>> iotest 245 changes output order due to buffering reasons.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   tests/qemu-iotests/030        |  4 +--
>>   tests/qemu-iotests/245        |  1 +
>>   tests/qemu-iotests/245.out    | 24 +++++++++---------
>>   tests/qemu-iotests/iotests.py | 47 +++++++++++++++++++++--------------
>>   4 files changed, 43 insertions(+), 33 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
>> index f3766f2a81..01aa96ed16 100755
>> --- a/tests/qemu-iotests/030
>> +++ b/tests/qemu-iotests/030
>> @@ -411,8 +411,8 @@ class TestParallelOps(iotests.QMPTestCase):
>>           result = self.vm.qmp('block-job-set-speed', device='drive0', speed=0)
>>           self.assert_qmp(result, 'return', {})
>>   
>> -        self.vm.run_job(job='drive0', auto_dismiss=True, use_log=False)
>> -        self.vm.run_job(job='node4', auto_dismiss=True, use_log=False)
>> +        self.vm.run_job(job='drive0', auto_dismiss=True)
>> +        self.vm.run_job(job='node4', auto_dismiss=True)
>>           self.assert_no_active_block_jobs()
>>   
>>       # Test a block-stream and a block-commit job in parallel
>> diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
>> index 41218d5f1d..eba2157cff 100644
>> --- a/tests/qemu-iotests/245
>> +++ b/tests/qemu-iotests/245
>> @@ -1000,5 +1000,6 @@ class TestBlockdevReopen(iotests.QMPTestCase):
>>           self.reopen(opts, {'backing': 'hd2'})
>>   
>>   if __name__ == '__main__':
>> +    iotests.activate_logging()
> 
> or it may be a parameter for main().. But I'm OK with this too, of course.
> 

I think most of the unittest style tests don't need or want logged
output in this way, but we can always do it later if we want.

>>       iotests.main(supported_fmts=["qcow2"],
>>                    supported_protocols=["file"])
>> diff --git a/tests/qemu-iotests/245.out b/tests/qemu-iotests/245.out
>> index a19de5214d..15c3630e92 100644
>> --- a/tests/qemu-iotests/245.out
>> +++ b/tests/qemu-iotests/245.out
>> @@ -1,17 +1,17 @@
>> +{"execute": "job-finalize", "arguments": {"id": "commit0"}}
>> +{"return": {}}
>> +{"data": {"id": "commit0", "type": "commit"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>> +{"data": {"device": "commit0", "len": 3145728, "offset": 3145728, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>> +{"execute": "job-finalize", "arguments": {"id": "stream0"}}
>> +{"return": {}}
>> +{"data": {"id": "stream0", "type": "stream"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>> +{"data": {"device": "stream0", "len": 3145728, "offset": 3145728, "speed": 0, "type": "stream"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>> +{"execute": "job-finalize", "arguments": {"id": "stream0"}}
>> +{"return": {}}
>> +{"data": {"id": "stream0", "type": "stream"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>> +{"data": {"device": "stream0", "len": 3145728, "offset": 3145728, "speed": 0, "type": "stream"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>>   ..................
>>   ----------------------------------------------------------------------
>>   Ran 18 tests
>>   
>>   OK
>> -{"execute": "job-finalize", "arguments": {"id": "commit0"}}
>> -{"return": {}}
>> -{"data": {"id": "commit0", "type": "commit"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>> -{"data": {"device": "commit0", "len": 3145728, "offset": 3145728, "speed": 0, "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>> -{"execute": "job-finalize", "arguments": {"id": "stream0"}}
>> -{"return": {}}
>> -{"data": {"id": "stream0", "type": "stream"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>> -{"data": {"device": "stream0", "len": 3145728, "offset": 3145728, "speed": 0, "type": "stream"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>> -{"execute": "job-finalize", "arguments": {"id": "stream0"}}
>> -{"return": {}}
>> -{"data": {"id": "stream0", "type": "stream"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>> -{"data": {"device": "stream0", "len": 3145728, "offset": 3145728, "speed": 0, "type": "stream"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
>> index 92117a64bc..7e46fb2754 100644
>> --- a/tests/qemu-iotests/iotests.py
>> +++ b/tests/qemu-iotests/iotests.py
>> @@ -35,6 +35,13 @@ from collections import OrderedDict
>>   sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
>>   from qemu import qtest
>>   
>> +# Use this logger for logging messages directly from the iotests module
>> +logger = logging.getLogger(__name__)
>> +logger.addHandler(logging.NullHandler())
>> +
>> +# Use this logger for messages that ought to be used for diff output.
>> +test_logger = logging.getLogger('.'.join((__name__, 'iotest')))
>> +test_logger.addHandler(logging.NullHandler())
> 
> Still, I see one "print" call left in notrun(). Should it be changed to use logger or test_logger?
> 

Good question...

I guess notrun() writes to the .notrun file, which the main test runner
uses to know not to check the output in stdout as a diff against the
reference output.

The 'check' runner then cats the .notrun file to stdout for the user to see.

the print() is discarded (unless we were in debug mode, and then it was
printed to the screen.)

It seems like a control message for the user, so my guess is that it
ought to be sent to the module-level logger and printed to stderr, actually.

maybe warning-level?

>>   
>>   # This will not work if arguments contain spaces but is necessary if we
>>   # want to support the override options that ./check supports.
>> @@ -343,10 +350,10 @@ def log(msg, filters=[], indent=None):
>>           separators = (', ', ': ') if indent is None else (',', ': ')
>>           # Don't sort if it's already sorted
>>           do_sort = not isinstance(msg, OrderedDict)
>> -        print(json.dumps(msg, sort_keys=do_sort,
>> -                         indent=indent, separators=separators))
>> +        test_logger.info(json.dumps(msg, sort_keys=do_sort,
>> +                                    indent=indent, separators=separators))
>>       else:
>> -        print(msg)
>> +        test_logger.info(msg)
>>   
>>   class Timeout:
>>       def __init__(self, seconds, errmsg = "Timeout"):
>> @@ -559,7 +566,7 @@ class VM(qtest.QEMUQtestMachine):
>>   
>>       # Returns None on success, and an error string on failure
>>       def run_job(self, job, auto_finalize=True, auto_dismiss=False,
>> -                pre_finalize=None, cancel=False, use_log=True, wait=60.0):
>> +                pre_finalize=None, cancel=False, wait=60.0):
>>           """
>>           run_job moves a job from creation through to dismissal.
>>   
>> @@ -572,7 +579,6 @@ class VM(qtest.QEMUQtestMachine):
>>                                invoked prior to issuing job-finalize, if any.
>>           :param cancel: Bool. When true, cancels the job after the pre_finalize
>>                          callback.
>> -        :param use_log: Bool. When false, does not log QMP messages.
>>           :param wait: Float. Timeout value specifying how long to wait for any
>>                        event, in seconds. Defaults to 60.0.
>>           """
>> @@ -590,8 +596,7 @@ class VM(qtest.QEMUQtestMachine):
>>           while True:
>>               ev = filter_qmp_event(self.events_wait(events))
>>               if ev['event'] != 'JOB_STATUS_CHANGE':
>> -                if use_log:
>> -                    log(ev)
>> +                log(ev)
>>                   continue
>>               status = ev['data']['status']
>>               if status == 'aborting':
>> @@ -599,24 +604,16 @@ class VM(qtest.QEMUQtestMachine):
>>                   for j in result['return']:
>>                       if j['id'] == job:
>>                           error = j['error']
>> -                        if use_log:
>> -                            log('Job failed: %s' % (j['error']))
>> +                        log('Job failed: %s' % (j['error']))
>>               elif status == 'pending' and not auto_finalize:
>>                   if pre_finalize:
>>                       pre_finalize()
>> -                if cancel and use_log:
>> +                if cancel:
>>                       self.qmp_log('job-cancel', id=job)
>> -                elif cancel:
>> -                    self.qmp('job-cancel', id=job)
>> -                elif use_log:
>> +                else:
>>                       self.qmp_log('job-finalize', id=job)
>> -                else:
>> -                    self.qmp('job-finalize', id=job)
>>               elif status == 'concluded' and not auto_dismiss:
>> -                if use_log:
>> -                    self.qmp_log('job-dismiss', id=job)
>> -                else:
>> -                    self.qmp('job-dismiss', id=job)
>> +                self.qmp_log('job-dismiss', id=job)
>>               elif status == 'null':
>>                   return error
> 
> I like this change. Interesting, should we just enable logging in qmp() and
> drop qmp_log() function, to always manage log/don't-log behavior through
> python logger? But this seems to be larger effort, including iotests output
> changes, not for these series.
> 

Yes, that's probably a good idea. One function that always logs, and
where that gets routed to and what happens to it is configured elsewhere.

We can work towards a unified logging story over time.

>>   
>> @@ -949,6 +946,7 @@ def execute_setup_common(supported_fmts=[],
>>       if debug:
>>           sys.argv.remove('-d')
>>       logging.basicConfig(level=(logging.DEBUG if debug else logging.WARN))
> 
> Hmm, interesting, am I right, that before this patch, this logging.basicConfig() line
> is the only use of logging module, and therefore unused?
> 

Oh, I see -- no, actually; this line turns on all of the debugging
statements in included modules too.

basicConfig, when executed *before any other logging statement*, will
create a defaultly-configured handler and logger at the root of the
hierarchy.

When you call basicConfig, you create and enable the root logger. Later,
when qmp.py calls logging.getLogger('QMP'), it attaches itself under the
root logger.

Then, messages will propagate from the QMP logger to the root logger.

So by enabling it here, you actually enable logging everywhere.

> Does it affect all existent loggers (i.e. logger and test_logger)? Hmm, seems not:
> "Does basic configuration for the logging system by creating a StreamHandler with a default Formatter and adding it to the root logger."
> 

You're half-right.

If other loggers *already exist*, basicConfig does nothing. If they
don't, it creates a default handler.

By effect, that default handler allows other loggers to propagate their
messages up to the root and in effect, it enables those loggers.

However, all loggers exist in one tree in a python process; so we can
enable and disable them post-hoc to our liking.

>> +    logger.debug("iotests debugging messages active")
>>   
>>       return debug
>>   
>> @@ -961,14 +959,25 @@ def execute_test(test_function=None, *args, **kwargs):
>>       else:
>>           test_function()
>>   
>> +def activate_logging():
>> +    """Activate iotests.log() output to stdout for script-style tests."""
>> +    handler = logging.StreamHandler(stream=sys.stdout)
>> +    formatter = logging.Formatter('%(message)s')
>> +    handler.setFormatter(formatter)
>> +    test_logger.addHandler(handler)
>> +    test_logger.setLevel(logging.INFO)
>> +    test_logger.propagate = False
>> +

Which is what I am doing here.

I create a formatter that does nothing but print the message as-is, and
a handler that routes the message to stdout.

Then I add the formatter to the handler, and the handler to the logger.
I turn on event processing at the INFO level and then turn off propagation.

>>   # This is called from script-style iotests without a single point of entry
>>   def script_initialize(*args, **kwargs):
>>       """Initialize script-style tests without running any tests."""
>> +    activate_logging()
>>       execute_setup_common(*args, **kwargs)
>>   
>>   # This is called from script-style iotests with a single point of entry
>>   def script_main(test_function, *args, **kwargs):
>>       """Run script-style tests outside of the unittest framework"""
>> +    activate_logging()
>>       execute_test(test_function, *args, **kwargs)
>>   
>>   # This is called from unittest style iotests
>>
> 
> 


