Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1403EC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 18:26:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4B3A24953
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 18:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AjCP8W2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B3A24953
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVfn5-0000I9-4s
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 14:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jVfly-0007Vk-DM
 for qemu-devel@nongnu.org; Mon, 04 May 2020 14:24:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50261
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jVflv-000398-KW
 for qemu-devel@nongnu.org; Mon, 04 May 2020 14:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588616693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=fN395cp6gGPk1Sb+o9wzCbQsHh53PBXagxBPVnbkJ7I=;
 b=AjCP8W2o5qX9eUKIsmJFAjz4oAFVxm9jiHbcFvgp5vtPL8BQpOAiP3l1H4p3zKJNkB6EoS
 OTcE7dtn7LVMU+xd/FJ7j6lxvo2mqYqr1Bd/w5yaQPFcb9bVW/0TKfu7zFuPP+ZOZPOqsY
 kkYkVTCk9lEBoRhVCios8/N2vosUG0s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-Ogdm-WW5MFiEixMZ4DmGnA-1; Mon, 04 May 2020 14:24:48 -0400
X-MC-Unique: Ogdm-WW5MFiEixMZ4DmGnA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BFAF107ACCA;
 Mon,  4 May 2020 18:24:47 +0000 (UTC)
Received: from [10.10.116.219] (ovpn-116-219.rdu2.redhat.com [10.10.116.219])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 457CC6B8E6;
 Mon,  4 May 2020 18:24:42 +0000 (UTC)
Subject: Re: [PATCH 4/4] scripts/qmp: Fix QEMU Python scripts path
To: Markus Armbruster <armbru@redhat.com>
References: <20200421094216.24927-1-f4bug@amsat.org>
 <20200421094216.24927-5-f4bug@amsat.org>
 <395d7263-c4f0-7422-0355-7e082135f6cd@redhat.com>
 <878sidimxu.fsf@dusky.pond.sub.org>
 <21ffc136-7905-e0aa-bad2-8d980fd15349@redhat.com>
 <87ees26fvh.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
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
Message-ID: <4a594969-4d6f-69ff-9a0e-4e23fdfaee5e@redhat.com>
Date: Mon, 4 May 2020 14:24:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87ees26fvh.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/2/20 1:54 AM, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
>=20
>> On 4/30/20 1:04 AM, Markus Armbruster wrote:
>>> John Snow <jsnow@redhat.com> writes:
>>>
>>>> On 4/21/20 5:42 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>> QEMU Python scripts have been moved in commit 8f8fd9edba4 ("Introduce
>>>>> Python module structure"). Use the same sys.path modification used
>>>>> in the referenced commit to be able to use these scripts again.
>>>>>
>>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>>> ---
>>>>>  scripts/qmp/qmp      | 4 +++-
>>>>>  scripts/qmp/qom-fuse | 4 +++-
>>>>>  scripts/qmp/qom-get  | 4 +++-
>>>>>  scripts/qmp/qom-list | 4 +++-
>>>>>  scripts/qmp/qom-set  | 4 +++-
>>>>>  scripts/qmp/qom-tree | 4 +++-
>>>>>  6 files changed, 18 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/scripts/qmp/qmp b/scripts/qmp/qmp
>>>>> index 0625fc2aba..8e52e4a54d 100755
>>>>> --- a/scripts/qmp/qmp
>>>>> +++ b/scripts/qmp/qmp
>>>>> @@ -11,7 +11,9 @@
>>>>>  # See the COPYING file in the top-level directory.
>>>>> =20
>>>>>  import sys, os
>>>>> -from qmp import QEMUMonitorProtocol
>>>>> +
>>>>> +sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', =
'python'))
>>>>> +from qemu.qmp import QEMUMonitorProtocol
>>>>> =20
>>>>
>>>> Try to avoid using sys.path hacks; they don't work in pylint or mypy a=
nd
>>>> it provides an active barrier to CQA work here.
>>>> (They also tend to be quite fragile.)
>>>>
>>>> We can discuss the right way to do this; one of those ways is to creat=
e
>>>> an installable package that we can install locally in a virtual enviro=
nment.
>>>>
>>>> Another way is perhaps to set PYTHONPATH in the calling environment so
>>>> that standard "import" directives will work.
>>>>
>>>> Both ultimately involve changing the environment of the user to
>>>> accommodate the script.
>>>
>>> For what it's worth, tests/Makefile.involve does the latter for
>>> tests/qapi-schema/test-qapi.py.  Simple enough, but makes manual
>>> invocation inconvenient.
>>>
>>> Not necessary for scripts/qapi-gen.py, because its "import qmp.FOO"
>>> finds qmp right in scripts/qmp/.
>>>
>>
>> Yes, using "proper" package hierarchies often means the loss of being
>> able to invoke the scripts directly, unless you are careful to organize
>> the package such that the scripts can run both in an "unpackaged" and a
>> "packaged" mode.
>>
>> It can be done, but it's tricky and can be prone to error. Let's take a
>> look at how to do it!
>>
>> Let's imagine we have an honest-to-goodness QAPI parser module. In
>> isolation, the layout for such a package would probably look like this:
>>
>> qapi.git/
>>   setup.py
>>   qapi-gen.py
>>   README.rst
>>   qapi/
>>     __init__.py
>>     parser.py
>>     schema.py
>>     ...etc
>>
>>
>> Now, anything inside of qapi/ is considered the "qapi module" and you
>> will be unable to directly execute anything inside of this folder,
>> unless it does not depend on anything else in the "qapi module".
>>
>> i.e. "import qapi.x" will work, but only from the executing context of a
>> thread that understands how to find "qapi". If you are IN this
>> directory, you do not have that context, so those directives will not wo=
rk.
>>
>> Python imports are always handled relative to the importing file, not
>> the imported file.
>>
>> qapi-gen in the parent directory, however, can use "from qapi import
>> parser" without any problem, because if you are executing it directly,
>> it will be able to see the "qapi module" as a folder.
>=20
> Hmm...
>=20
>     $ git-grep '^from.*schema' scripts/
>     scripts/qapi-gen.py:from qapi.schema import QAPIError, QAPISchema
>     scripts/qapi/events.py:from qapi.schema import QAPISchemaEnumMember
>     scripts/qapi/gen.py:from qapi.schema import QAPISchemaVisitor
>     scripts/qapi/introspect.py:from qapi.schema import (QAPISchemaArrayTy=
pe, QAPISchemaBuiltinType,
>     scripts/qapi/types.py:from qapi.schema import QAPISchemaEnumMember, Q=
APISchemaObjectType
>     scripts/qapi/visit.py:from qapi.schema import QAPISchemaObjectType
>=20
> How come importing from qapi. works in scripts/qapi/*.py, too?
>=20
> [...]
>=20

Because they're being consumed from the POV of the entry point, which is
scripts/qapi-gen.py.

That is to say, if in scripts/qapi/ you create a new file:

helloworld.py:
```
#!/usr/bin/env python3

from qapi.schema import QAPIError
```

And then execute it:

jsnow@probe ~/s/q/s/qapi ((v5.0.0))> ./helloworld.py
Traceback (most recent call last):
  File "./helloworld.py", line 3, in <module>
    from qapi.schema import QAPIError
ModuleNotFoundError: No module named 'qapi'


It doesn't know what qapi is. Python modules do not carry the
information or metadata themselves inherently to know that they are "in
a module."

That information is known only to qapi-gen.py, and files it brings in
use the namespace set up by qapi-gen.py -- not their own.

This is what I was trying to explain in the last mail about how to lay
out a python module -- and why it's tricky to write imports in such a
way that they preserve "run as script" semantics while also providing
"run as installed package semantics".

Put another way:

qapi-gen.py is considered a /client of/ the qapi module when it is in a
folder above/outside of the QAPI module. If you refactor the module to
include such a script, by moving it into that module's directory -- you
lose your "client" and you no longer have an entry point. (i.e. you
cannot just run the script in the folder any more.)

You can remedy this in several ways:

1. Set PYTHONPATH to include the folder that the `qapi` folder is in, so
that even when executing e.g. somedir/qapi/scripts.py, it knows to look
in "somedir" when evaluating imports.

2. Create a new shim that exists outside of the module proper that does
nothing but import and then execute the script. E.g., "somedir/shim.py"
that just loads the script from qapi/scripts.py and then runs it. This
is basically equivalent to #1, but doesn't require a special ENV for the
user.

3. Use the package installation facilities (setuptools) to define a
"script entry point", which in practice just uses setuptools to
automatically generate a shim for you that gets placed in e.g.
~/.local/bin/ and makes the script available on the command-line.


So I just want to point out that packaging python modules is possible,
and it's a good thing to do, but "runnable scripts" present a problem
WRT lookup paths depending on how they are written!

--js


