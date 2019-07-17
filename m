Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A1DC7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 15:57:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5709B21743
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 15:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5709B21743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnmJF-0002zd-Be
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 11:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38892)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hnmJ1-0002NV-Cf
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 11:57:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hnmIz-00080m-Ml
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 11:57:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60002)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hnmIw-0007x8-1L; Wed, 17 Jul 2019 11:57:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ACFF53099FC4;
 Wed, 17 Jul 2019 15:57:15 +0000 (UTC)
Received: from [10.18.17.203] (dhcp-17-203.bos.redhat.com [10.18.17.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A43B460BE2;
 Wed, 17 Jul 2019 15:57:14 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
References: <20190530143941.241963-1-vsementsov@virtuozzo.com>
 <c7ef8501-0c9f-f21b-1b60-dcd7dba03557@redhat.com>
 <f9af022a-7acf-bb1c-3d2c-b095bff2e251@redhat.com>
 <2a9f6327-1cb6-78eb-ad10-93a33c6e754c@redhat.com>
 <87a7ew9p3o.fsf@dusky.pond.sub.org>
 <4ee9736d-4e49-6572-e6e8-94739d155323@redhat.com>
 <874l3mqykj.fsf@dusky.pond.sub.org>
 <cc61946a-2b26-51d1-581d-b12cc80f41c0@redhat.com>
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
Message-ID: <131c0677-03c9-a8d2-3c8b-f27f1fae7cfd@redhat.com>
Date: Wed, 17 Jul 2019 11:57:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <cc61946a-2b26-51d1-581d-b12cc80f41c0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Wed, 17 Jul 2019 15:57:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] qapi: add dirty-bitmaps to
 query-named-block-nodes result
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
Cc: kwolf@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 nshirokovskiy@virtuozzo.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 7/16/19 11:26 AM, John Snow wrote:
> 
> 
> On 7/16/19 2:32 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>>
>>> On 6/5/19 8:46 AM, Markus Armbruster wrote:
>>>> John Snow <jsnow@redhat.com> writes:
>>>>
>>>>> On 5/31/19 10:55 AM, Eric Blake wrote:
>>>>>> On 5/30/19 11:26 AM, John Snow wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 5/30/19 10:39 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>>> Let's add a possibility to query dirty-bitmaps not only on root nodes.
>>>>>>>> It is useful when dealing both with snapshots and incremental backups.
>>>>>>>>
>>>>>>
>>>>>>>> +++ b/block/qapi.c
>>>>>>>> @@ -78,6 +78,11 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
>>>>>>>>          info->backing_file = g_strdup(bs->backing_file);
>>>>>>>>      }
>>>>>>>>  
>>>>>>>> +    if (!QLIST_EMPTY(&bs->dirty_bitmaps)) {
>>>>>>>> +        info->has_dirty_bitmaps = true;
>>>>>>>> +        info->dirty_bitmaps = bdrv_query_dirty_bitmaps(bs);
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>>      info->detect_zeroes = bs->detect_zeroes;
>>>>>>>>  
>>>>>>>>      if (blk && blk_get_public(blk)->throttle_group_member.throttle_state) {
>>>>>>>>
>>>>>>>
>>>>>>> So query-block uses bdrv_query_info, which calls bdrv_block_device_info,
>>>>>>> so we'll duplicate the bitmap output when doing the old-fashioned block
>>>>>>> query, but that's probably harmless overall.
>>>>>>
>>>>>> We already know that none of our existing query- interfaces are sane
>>>>>> (either too little information, or too much).  Duplication starts to
>>>>>> push an interface towards too much (it takes processor time to bundle up
>>>>>> the extra JSON, especially if the other end is not going to care if it
>>>>>> was present). I know Kevin still has somewhere on his to-do list the
>>>>>> implementation of a saner query- command for the information we really
>>>>>> want (about each block, without redundant information, and where we
>>>>>> don't repeat information in a nested manner, but where we also don't
>>>>>> omit information that would otherwise require multiple existing query-
>>>>>> to reconstruct).
>>>>>>
>>>>>>>
>>>>>>> We can continue to support the output in both places, or we could opt to
>>>>>>> deprecate the older interface; I think this is one of the last chances
>>>>>>> we'd get to do so before libvirt and wider adoption.
>>>>>>>
>>>>>>> I think that's probably Eric's choice.
>>>>>>
>>>>>> If you want to try to deprecate the old location, introspection at least
>>>>>> works to allow libvirt to know which place to look for it on a given
>>>>>> qemu. If you don't think deprecation is necessary, the duplication is
>>>>>> probably tolerable for now (as ideally we'd be deprecating ALL of our
>>>>>> not-quite-perfect query- block interfaces in favor of whatever sane
>>>>>> interface Kevin comes up with).
>>>>>>
>>>>>
>>>>> It sounds like it's probably the right move to deprecate the entire
>>>>> legacy interface, but still... If you have 20 or 30 bitmaps on a root
>>>>> node, you will see 40 or 60 entries.
>>>>>
>>>>> What's the smart way to deprecate it? We're not adding new flags or
>>>>> showing new arguments or anything. There might not be bitmaps, so you
>>>>> can't rely on that field being present or absent.
>>>>>
>>>>> Recommendations?
>>>>
>>>> Kevin's "[PATCH v4 0/6] file-posix: Add dynamic-auto-read-only QAPI
>>>> feature" adds "feature flags" to the QAPI schema language, limited to
>>>> struct types, because that's what he needs.  They're visible in
>>>> introspection.  I intend to complete his work, so we can tack
>>>> "deprecated" feature flags to pretty much anything
>>>>
>>>> Could that address your need?
>>>>
>>>
>>> Hi Markus, digging this up again.
>>>
>>> In brief, we are displaying bitmap info in the "wrong" part of the query
>>> result (attached to drive instead of node) and would like to change it.
>>
>> I lack context: which query command, which part of its result?
>>
> 
> query-block (or is it block-query? Well, you know the one.)
> 
> It's the optional *dirty-bitmaps field. It's present when there are
> bitmaps attached to the root of the device.
> 
>>> I'd like to avoid reporting bitmaps in both locations permanently, so if
>>> we have a plan to deprecate reporting bitmaps in the old location, I
>>> will tolerate the duplicated output temporarily.
>>
>> How bulky is the bitmap report?
>>
> 
> @BlockDirtyInfo structure, four bools, a deprecated enum, uint32 and an in.
> 
> However, there can be any number of them. Possibly very many. If you
> have 30 of them on the root node, adding their output to the correct
> node means you will now see 60 bitmaps reported. (Augh.)
> 
> However, see below, if you add them to a node that doesn't qualify for
> this top-level output, you'll only see them once.
> 
> [Incremental backup paradigm: only one per backup chain.
>  Pull-mode checkpoint paradigm, at least n+1 bitmaps for n checkpoints.]
> 
>>> Keeping in mind the bitmap fields are optional (so they can be absent
>>> from both the new and old locations), what plan can we implement?
>>
>> "Optional" is a syntactic thing, which ought to be backed by a semantic
>> "present iff" condition.  Have we specified such conditions?
>>
> 
> The BlockDirtyInfo is present when there are dirty bitmaps attached to
> the root node of the "device".
> 
> (This special case, bitmaps attached to the "root" of a "device", may or
> may not work completely correctly with anonymous BlockBackend structures
> and other non-sugared syntaxes which seemingly create "special" trees
> that cannot be replicated precisely with QMP commands. I forget the
> particulars at the present moment.)
> 
>>> Perhaps I can add a feature flag "has-node-bitmaps" for 4.2. Then, for
>>> the next three versions, I will report bitmaps from both locations.
>>> Then, in 5.2+ I will remove the old location.
>>
>> For how long has the bitmap been in the "wrong" place?  Any known
>> consumers?
>>
> 
> 1. Since it was introduced.
> 
> It's just that most of our use cases revolved around bitmaps being
> attached in this way. With blockdev-backup and more flexible backup
> modes, we might be creating bitmaps on nodes that aren't traditional
> drives, and we need to be able to query those. We have no way to do so
> in 4.1.
> 
> So we have had the ability to create mysterious, unqueriable bitmaps for
> quite some time; since 2.4 at least.
> 
> 
> 2. Harder to answer. Yes, iotests 124 and 256 and 257 and others look
> for bitmaps via block-query. These are all the "named" style bitmaps,
> which I added in 2.4-ish timeframe. They've always been in this weird place.
> 
> However, dirty-bitmaps field has existed even before then, and was used
> for communicating information about the implicit dirty bitmap used by
> the mirror job. Paolo added that in 1.x, a long long time ago.
> 
> 21b56835086 (Nov 13 2013) changed this field from "dirty" to
> "dirty-bitmaps" with no justification for the break in compatibility.
> The "dirty" field was the one used exclusively for mirror job's dirty
> information, and this commit and series added support for named bitmaps,
> and is now used primarily user-created, named bitmap objects. (But it
> still reports the old, anonymous implicit type for mirror.)
> 
> Are there any users for this other kind of bitmap? Completely unknown.
> 
> I don't think we use it in iotests, and I don't see evidence of libvirt
> using it. (I just checked with pkrempa and he doesn't seem to think it's
> used that way either.)
> 
>>> A client knows it can find bitmaps (if there are any) in the new
>>> location if the feature flag is set. Otherwise, it should look in the
>>> old location.
>>>
>>> I think I've convinced myself that this is correct, so correct me if I
>>> am wrong.
>>
>> Sounds like a valid use of feature flags to me.  However, feature flags
>> are best used as a last resort.  With answers to my questions, I should
>> be able to compare the feature flags solution to possible alternatives.
>>
> 

Update: I convinced myself I'm wrong, because even if the *output* isn't
always present, it's enough that the field is present via introspection.

So I'll resend my other version of this patch without the feature flag.

--js

