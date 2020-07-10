Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E66C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:53:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DD0E20720
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eOHXHqf3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD0E20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtvLI-0005xy-7B
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 11:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jtvGp-00009S-GB
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:49:03 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23213
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jtvGj-0000Dz-8q
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594396136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=m5cpUiUUhV6UUgHDSGYUfQyZjMxg40912+dGihY7WVo=;
 b=eOHXHqf326WoqMj+CExmyJ0abNLQjCkbILKtz/FROe4KNZBFrz9my56fc8mi6jOgsyCDJL
 hj4/shADNCNF/6qHf44Src/SzMb5xYHXMAY1u7GMPdhq2WBzEdcyobtHmiHtL6vvCU+oBX
 MhqMBn54l7cX516FVXPSHd0vkD5kchE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-m6p_AryHNl2yASyQsoD18w-1; Fri, 10 Jul 2020 11:48:48 -0400
X-MC-Unique: m6p_AryHNl2yASyQsoD18w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44FF7106B249;
 Fri, 10 Jul 2020 15:48:47 +0000 (UTC)
Received: from [10.10.118.196] (ovpn-118-196.rdu2.redhat.com [10.10.118.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2BAF210016E8;
 Fri, 10 Jul 2020 15:48:46 +0000 (UTC)
Subject: Re: [PULL 03/31] iotests: Make _filter_img_create more active
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200706100432.2301919-1-mreitz@redhat.com>
 <20200706100432.2301919-4-mreitz@redhat.com>
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
Message-ID: <e284ba86-755d-51c4-d8b0-926ad240a91a@redhat.com>
Date: Fri, 10 Jul 2020 11:48:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200706100432.2301919-4-mreitz@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 23:35:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 7/6/20 6:04 AM, Max Reitz wrote:
> Right now, _filter_img_create just filters out everything that looks
> format-dependent, and applies some filename filters.  That means that we
> have to add another filter line every time some format gets a new
> creation option.  This can be avoided by instead discarding everything
> and just keeping what we know is format-independent (format, size,
> backing file, encryption information[1], preallocation) or just
> interesting to have in the reference output (external data file path).
> 
> Furthermore, we probably want to sort these options.  Format drivers are
> not required to define them in any specific order, so the output is
> effectively random (although this has never bothered us until now).  We
> need a specific order for our reference outputs, though.  Unfortunately,
> just using a plain "sort" would change a lot of existing reference
> outputs, so we have to pre-filter the option keys to keep our existing
> order (fmt, size, backing*, data, encryption info, preallocation).
> 
> Finally, this makes it difficult for _filter_img_create to automagically
> work for QMP output.  Thus, this patch adds a separate
> _filter_img_create_for_qmp function that echos every line verbatim that
> does not start with "Formatting", and pipes those "Formatting" lines to
> _filter_img_create.
> 
> [1] Actually, the only thing that is really important is whether
>     encryption is enabled or not.  A patch by Maxim thus removes all
>     other "encrypt.*" options from the output:
>     https://lists.nongnu.org/archive/html/qemu-block/2020-06/msg00339.html
>     But that patch needs to come later so we can get away with changing
>     as few reference outputs in this patch here as possible.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Message-Id: <20200625125548.870061-2-mreitz@redhat.com>
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>


Hi, I am seeing breakage on travis-ci;

https://travis-ci.org/github/jnsnow/qemu/jobs/706915953#L2236

(Disclaimer: Has my python patches applied)

There's some ambiguity perhaps over the order required by data_file /
data_file_raw.

Also in the IRC channel, pm215 notes that there is a breakage on OSX as
'readarray' is a bash 4.0 feature, and OSX has only bash 3.2:

11:34 < stsquad> MacOSX iotest failures
11:34 < stsquad> Not run: 005 013 018 019 024 034 038 039 041 048 060
061 074 079 080 086 097 099 108 137 138 140 141 150 154 161 172 176 179 181
                 184 203 220 226 229 244 249 251 252 259 265 267 287 290
292z
11:34 < stsquad> Failures: 001 002 003 004 007 008 009 010 011 012 017
020 021 022 025 027 029 031 032 033 035 036 037 042 043 046 047 050 052
                 053 054 062 063 066 069 071 072 073 089 090 098 103 104
105 107 110 111 114 117 120 126 127 133 134 156 158 159 170 174 177 186
                 187 190 191 192 195 214 217 268
11:34 < stsquad> Failed 69 of 75 iotests
11:34 < stsquad> that sounds like a bash-ism has snuck in?
11:36 < pm215> stsquad: readarray is in bash 4, osx system bash is 3.2
11:36 < pm215> dunno why that didn't fail for my own osx box
11:38 < th_huth> pm215: does "make check" run the iotests on your osx
box at all? Maybe it is missing gnu-sed ?
11:39 < pm215> th_huth: ah, it doesn't: "GNU sed not available ==> Not
running the qemu-iotests"
11:39 < th_huth> too bad :-(


> ---
>  tests/qemu-iotests/112.out       |   2 +-
>  tests/qemu-iotests/141           |   2 +-
>  tests/qemu-iotests/153           |   9 ++-
>  tests/qemu-iotests/common.filter | 109 ++++++++++++++++++++++++-------
>  4 files changed, 91 insertions(+), 31 deletions(-)
> 
> diff --git a/tests/qemu-iotests/112.out b/tests/qemu-iotests/112.out
> index ae0318cabe..182655dbf6 100644
> --- a/tests/qemu-iotests/112.out
> +++ b/tests/qemu-iotests/112.out
> @@ -5,7 +5,7 @@ QA output created by 112
>  qemu-img: TEST_DIR/t.IMGFMT: Refcount width must be a power of two and may not exceed 64 bits
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
>  qemu-img: TEST_DIR/t.IMGFMT: Refcount width must be a power of two and may not exceed 64 bits
> -Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 refcount_bits=-1
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
>  qemu-img: TEST_DIR/t.IMGFMT: Refcount width must be a power of two and may not exceed 64 bits
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
>  qemu-img: TEST_DIR/t.IMGFMT: Refcount width must be a power of two and may not exceed 64 bits
> diff --git a/tests/qemu-iotests/141 b/tests/qemu-iotests/141
> index 5192d256e3..6d1b7b0d4c 100755
> --- a/tests/qemu-iotests/141
> +++ b/tests/qemu-iotests/141
> @@ -68,7 +68,7 @@ test_blockjob()
>      _send_qemu_cmd $QEMU_HANDLE \
>          "$1" \
>          "$2" \
> -        | _filter_img_create | _filter_qmp_empty_return
> +        | _filter_img_create_in_qmp | _filter_qmp_empty_return
>  
>      # We want this to return an error because the block job is still running
>      _send_qemu_cmd $QEMU_HANDLE \
> diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
> index cf961d3609..11e3d28841 100755
> --- a/tests/qemu-iotests/153
> +++ b/tests/qemu-iotests/153
> @@ -167,11 +167,10 @@ done
>  
>  echo
>  echo "== Creating ${TEST_IMG}.[abc] ==" | _filter_testdir
> -(
> -    $QEMU_IMG create -f qcow2 "${TEST_IMG}.a" -b "${TEST_IMG}"
> -    $QEMU_IMG create -f qcow2 "${TEST_IMG}.b" -b "${TEST_IMG}"
> -    $QEMU_IMG create -f qcow2 "${TEST_IMG}.c" -b "${TEST_IMG}.b"
> -) | _filter_img_create
> +$QEMU_IMG create -f qcow2 "${TEST_IMG}.a" -b "${TEST_IMG}" | _filter_img_create
> +$QEMU_IMG create -f qcow2 "${TEST_IMG}.b" -b "${TEST_IMG}" | _filter_img_create
> +$QEMU_IMG create -f qcow2 "${TEST_IMG}.c" -b "${TEST_IMG}.b" \
> +    | _filter_img_create
>  
>  echo
>  echo "== Two devices sharing the same file in backing chain =="
> diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
> index 03e4f71808..f8cd80ff1f 100644
> --- a/tests/qemu-iotests/common.filter
> +++ b/tests/qemu-iotests/common.filter
> @@ -122,38 +122,99 @@ _filter_actual_image_size()
>  # replace driver-specific options in the "Formatting..." line
>  _filter_img_create()
>  {
> -    data_file_filter=()
> -    if data_file=$(_get_data_file "$TEST_IMG"); then
> -        data_file_filter=(-e "s# data_file=$data_file##")
> +    # Split the line into the pre-options part ($filename_part, which
> +    # precedes ", fmt=") and the options part ($options, which starts
> +    # with "fmt=")
> +    # (And just echo everything before the first "^Formatting")
> +    readarray formatting_line < <($SED -e 's/, fmt=/\n/')
> +
> +    filename_part=''
> +    options=''
> +    lines=${#formatting_line[@]}
> +    for ((i = 0; i < $lines; i++)); do
> +        line=${formatting_line[i]}
> +        unset formatting_line[i]
> +
> +        filename_part="$filename_part$line"
> +
> +        if echo "$line" | grep -q '^Formatting'; then
> +            next_i=$((i + 1))
> +            if [ -n "${formatting_line[next_i]}" ]; then
> +                options="fmt=${formatting_line[@]}"
> +            fi
> +            break
> +        fi
> +    done
> +
> +    # Set grep_data_file to '\|data_file' to keep it; make it empty
> +    # to drop it.
> +    # We want to drop it if it is part of the global $IMGOPTS, and we
> +    # want to keep it otherwise (if the test specifically wants to
> +    # test data files).
> +    grep_data_file=(-e data_file)
> +    if _get_data_file "$TEST_IMG" > /dev/null; then
> +        grep_data_file=()
>      fi
>  
> -    $SED "${data_file_filter[@]}" \
> +    filename_filters=(
>          -e "s#$REMOTE_TEST_DIR#TEST_DIR#g" \
>          -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
>          -e "s#$TEST_DIR#TEST_DIR#g" \
>          -e "s#$SOCK_DIR#SOCK_DIR#g" \
>          -e "s#$IMGFMT#IMGFMT#g" \
>          -e 's#nbd:127.0.0.1:[0-9]\\+#TEST_DIR/t.IMGFMT#g' \
> -        -e 's#nbd+unix:///\??socket=SOCK_DIR/nbd#TEST_DIR/t.IMGFMT#g' \
> -        -e "s# encryption=off##g" \
> -        -e "s# cluster_size=[0-9]\\+##g" \
> -        -e "s# table_size=[0-9]\\+##g" \
> -        -e "s# compat=[^ ]*##g" \
> -        -e "s# compat6=\\(on\\|off\\)##g" \
> -        -e "s# static=\\(on\\|off\\)##g" \
> -        -e "s# zeroed_grain=\\(on\\|off\\)##g" \
> -        -e "s# subformat=[^ ]*##g" \
> -        -e "s# adapter_type=[^ ]*##g" \
> -        -e "s# hwversion=[^ ]*##g" \
> -        -e "s# lazy_refcounts=\\(on\\|off\\)##g" \
> -        -e "s# block_size=[0-9]\\+##g" \
> -        -e "s# block_state_zero=\\(on\\|off\\)##g" \
> -        -e "s# log_size=[0-9]\\+##g" \
> -        -e "s# refcount_bits=[0-9]\\+##g" \
> -        -e "s# key-secret=[a-zA-Z0-9]\\+##g" \
> -        -e "s# iter-time=[0-9]\\+##g" \
> -        -e "s# force_size=\\(on\\|off\\)##g" \
> -        -e "s# compression_type=[a-zA-Z0-9]\\+##g"
> +        -e 's#nbd+unix:///\??socket=SOCK_DIR/nbd#TEST_DIR/t.IMGFMT#g'
> +    )
> +
> +    filename_part=$(echo "$filename_part" | $SED "${filename_filters[@]}")
> +
> +    # Break the option line before each option (preserving pre-existing
> +    # line breaks by replacing them by \0 and restoring them at the end),
> +    # then filter out the options we want to keep and sort them according
> +    # to some order that all block drivers used at the time of writing
> +    # this function.
> +    options=$(
> +        echo "$options" \
> +        | tr '\n' '\0' \
> +        | $SED -e 's/ \([a-z0-9_.-]*\)=/\n\1=/g' \
> +        | grep -a -e '^fmt' -e '^size' -e '^backing' -e '^preallocation' \
> +                  -e '^encrypt' "${grep_data_file[@]}" \
> +        | $SED "${filename_filters[@]}" \
> +            -e 's/^\(fmt\)/0-\1/' \
> +            -e 's/^\(size\)/1-\1/' \
> +            -e 's/^\(backing\)/2-\1/' \
> +            -e 's/^\(data_file\)/3-\1/' \
> +            -e 's/^\(encryption\)/4-\1/' \
> +            -e 's/^\(encrypt\.format\)/5-\1/' \
> +            -e 's/^\(encrypt\.key-secret\)/6-\1/' \
> +            -e 's/^\(encrypt\.iter-time\)/7-\1/' \
> +            -e 's/^\(preallocation\)/8-\1/' \
> +        | sort \
> +        | $SED -e 's/^[0-9]-//' \
> +        | tr '\n\0' ' \n' \
> +        | $SED -e 's/^ *$//' -e 's/ *$//'
> +    )
> +
> +    if [ -n "$options" ]; then
> +        echo "$filename_part, $options"
> +    elif [ -n "$filename_part" ]; then
> +        echo "$filename_part"
> +    fi
> +}
> +
> +# Filter the "Formatting..." line in QMP output (leaving the QMP output
> +# untouched)
> +# (In contrast to _filter_img_create(), this function does not support
> +# multi-line Formatting output)
> +_filter_img_create_in_qmp()
> +{
> +    while read -r line; do
> +        if echo "$line" | grep -q '^Formatting'; then
> +            echo "$line" | _filter_img_create
> +        else
> +            echo "$line"
> +        fi
> +    done
>  }
>  
>  _filter_img_create_size()
> 

-- 
—js


