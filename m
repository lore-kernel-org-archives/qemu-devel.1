Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B23DC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 20:58:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7D6B217BA
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 20:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NBjscHu6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D6B217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0AhT-0001CZ-0O
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 15:58:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1j0Agb-0000jc-Uh
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 15:57:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1j0AgX-0006yv-1R
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 15:57:12 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52359
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1j0AgW-0006sh-In
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 15:57:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581109027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NMCPcfJvmLaCgVIxPsWuBeHczMdwAgugBMK7Lc7rSBs=;
 b=NBjscHu6TVRstve9tVcWqfWIfKz6HNVV8BHf24uTbRqdd2mQ8zstK92qcgZEo77og+YYzC
 ZbONLxfOXSVSGgk9s8bIDIOJ+Mp2AOVin0pRU5cE1BmTbROqGDikfmqPZe2gUIzf54Eztz
 GlgsheVYnu1S502ChSFLJlPH232mj/Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-ii09aOXmM6uXNiVt8POIpQ-1; Fri, 07 Feb 2020 15:57:00 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71CFD800D55;
 Fri,  7 Feb 2020 20:56:58 +0000 (UTC)
Received: from [10.10.124.0] (ovpn-124-0.rdu2.redhat.com [10.10.124.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C78F5DA7E;
 Fri,  7 Feb 2020 20:56:49 +0000 (UTC)
Subject: Re: qmp-shell for GSoC/Outreachy?
To: Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <878slyej29.fsf@dusky.pond.sub.org>
 <a41ae09b-021f-2fda-0b03-7b37c5624ab3@redhat.com>
 <20200123190145.GI657556@redhat.com>
 <2561a069-ce5f-3c30-b04e-db7cd2fcdc85@redhat.com>
 <20200124095027.GA824327@redhat.com> <20200127143505.GD5669@linux.fritz.box>
 <20200127202925.GE3419@work-vm> <20200128105932.GC6431@linux.fritz.box>
 <20200205130946.GC5768@dhcp-200-226.str.redhat.com>
 <a45df5ab-3cad-0fbe-901f-4bc1ba28d38e@redhat.com>
 <20200205194944.GP3210@work-vm> <877e10xdd6.fsf@dusky.pond.sub.org>
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
Message-ID: <a6aa1e23-82ce-2dfc-168e-6759cf22d3c9@redhat.com>
Date: Fri, 7 Feb 2020 15:56:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <877e10xdd6.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: ii09aOXmM6uXNiVt8POIpQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, Cleber Rosa <cleber@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Dominik Csapak <d.csapak@proxmox.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2/6/20 4:40 AM, Markus Armbruster wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
> 
>> * John Snow (jsnow@redhat.com) wrote:
>>> I'm forking the subject as I believe Markus wanted to focus on the
>>> machine interface aspect.
>>>
>>> I feel that a new human interface is *related* to that goal: the
>>> splitting of, and commitment to, separate human and machine interfaces
>>> powered by a single root schema.
> 
> A bit of history.
> 
> QMP initially shared HMP's "schema": qemu-monitor.hx.  The command
> handler was either a traditional HMP one, or a QMP-enabling pair (QMP
> handler, HMP formatter).  The idea was to convert traditional HMP
> handlers one by one, then ditch support for them.
> 
> With a QMP handler, HMP became a wrapper around QMP.  The input wrapping
> was data-driven: @args_type specifies how to map HMP arguments to QMP.
> The output wrapper was code, namely the HMP formatter.
> 
> This design turned out to tie QMP to HMP too tightly.  It assumes QMP
> and HMP commands are identical apart from argument syntax and output
> formatting.  They often should not be.  QMP wants building blocks:
> simple commands with simple replies, in particular simple failure modes.
> HMP wants convenience.  QMP wants rigor.  HMP has uses where that's a
> painful and unnecessary.
> 
> So we split qemu-monitor.hx into hmp-commands.hx and qmp-commands.hx.
> The former reverted back to the pre-QMP state, and the latter lost
> support for HMP wrappers.  QMP was liberated from having to reimplement
> HMP.  HMP was liberated from always having to do QMP first.
> 
> qmp-commands.hx was eventually replaced by the QAPI schema.
> 
> The lesson here is that to make "powered by a single root schema" work
> well, we'll likely have to put in more smarts than we did back then.
> 

Yes, understood: this is rigorous work that we've failed at before. It's
a big task; but I feel like we are increasingly hurt by our focus on QMP
and leaving HMP in the dust.

Unifying them might be the only reasonable forward-thinking thing, even
if it's hard.

> More on that below in reply to David's reply.
> 
>>> I am a big believer in making QEMU usable directly to human users as I
>>> feel the pipeline of "tinker to deployment" is important for a
>>> successful project, for many reasons:
>>>
>>> - QEMU should be easy to pick up and learn.
>>>
>>> - Supporting QEMU's use directly as an "end-user" program increases
>>> proficiency in the user population at large, which (can) lead to better
>>> answers and engagement on e.g. Reddit, StackOverflow, IRC
>>>
>>> - Evolving deployments from QEMU-only to libvirt+ or above (RHV, oVirt,
>>> kubevirt) should be a smooth and gradual process as additional
>>> complexity is desired.
>>>
>>> - Focusing on QEMU's usability allows our project to be consumed easier
>>> by new cloud-focused projects. If they are already familiar with (and
>>> happy with) our project, it is more likely to be used instead of seeking
>>> out alternatives. This is about reducing friction.
>>>
>>> So, for those reasons ... even though I feel that a machine-focused API
>>> is our #1 priority as it caters to our existing users, we should also
>>> focus on what it will take to grow mindshare for QEMU's value in the
>>> ecosystem.
>>>
>>> Slick interfaces and documentation go a long, long way to doing that.
>>>
>>> So: I feel that any new machine-only paradigm or overhaul needs to be
>>> accompanied with some new sugar to help the medicine go down, so-to-speak.
> 
> Points taken.
> 
>>> On 2/5/20 8:09 AM, Kevin Wolf wrote:
>>>> Am 28.01.2020 um 11:59 hat Kevin Wolf geschrieben:
>>>>>>> The other part that it needs to solve is how to be available by default
>>>>>>> without specifying anything on the command line. Basically, if I press
>>>>>>> Ctrl-Alt-2, I want to get to a monitor shell. If that shell is
>>>>>>> implemented internally or by an external Python process, I don't mind.
>>>>>>
>>>>>> That is a harder part. (I rarely use Ctrl-Alt-2 actually; I mostly
>>>>>> use HMP on stdin).
>>>>>
>>>>> I don't think it would be that hard, actually.
>>>>>
>>>>> If you have a -qmp-shell option that takes a chardev and defaults to vc,
>>>>> you've solved the part with both stdio and Ctrl-Alt-2. Now all you need
>>>>> to do is launch the Python child process, pass it a pair of pipes for
>>>>> communication and forward everything between the pipes and the chardev.
>>>>>
>>>>> (That's the theory anyway.)
>>>>
>>>> If someone is interested, I did a quick proof-of-concept hack:
>>>>
>>>>     https://repo.or.cz/qemu/kevin.git/shortlog/refs/heads/qmp-shell
>>>>
>>>> It doesn't clean up anything properly (including the qmp-shell processes
>>>> it starts), but it spawns a usable qmp-shell on a user-specified
>>>> character device. stdio seems to work, though without readline
>>>> functionality (I suppose I still have line-buffering somewhere), vc
>>>> doesn't really work at all yet.
>>>>
>>>> Try it out like this:
>>>>
>>>>     $ ./qemu-storage-daemon --chardev stdio,id=m --monitor m,mode=qmp-shell
>>>>     monitor_qmp_event: 1
>>>>     Welcome to the QMP low-level shell!
>>>>     Connected to QEMU 4.2.50
>>>>
>>>>     (QEMU) query-version
>>>>     {"return": {"qemu": {"micro": 50, "major": 4, "minor": 2}, "package": "v4.2.0-1188-gd95a3885a9"}}
>>>>     (QEMU) quit
>>>>
>>>> (Or use x86_64-softmmu/qemu-system-x86_64, but it's based on the
>>>> refactorings in the storage daemon branch, so why not try both at once?)
>>>>
>>>> Polishing this to make it mergable would still require substantial work,
>>>> so at the moment I'm not planning to do this. But if someone wants to
>>>> pick it up, feel free (just let us know).
>>>>
>>>> Hm, in fact... A qmp-shell GSoC project?
>>>>
>>>
>>> That would be great. I worry that we should have a clear vision for the
>>> syntax before we give this project to an intern, though. With a clear
>>> vision and an outline for deliverables, it's an incredibly appropriate
>>> project.
>>>
>>> Some things I think we want to define before we start:
>>>
>>> 1. What are we trying to achieve with a standalone shell?
> 
> Projects without a clear goal rarely succeed.  Success within three
> months is even rarer.
> 
>>> 2. What syntax should it use?
> 
> Leaving that to a GSoC student amounts to setting up for failure.
> 
>>> I think those are the hardest parts.
>>>
>>> Below, some musings:
>>>
>>> - An integrated QMP shell would be a great usability boost to users of
>>> bare QEMU.
>>>
>>> - It is undesirable in general to support two interfaces. Feature
>>> disparity is a problem, as is needing to document and test two separate
>>> interfaces. The quality disparity between the two is also an issue.
>>>
>>> - Offering HMP via the GTK interface but not QMP is a discoverability
>>> problem. Unfamiliar users might assume that HMP is our flagship
>>> interface. It is not.
>>>
>>> - We are unlikely to re-expand HMP to cover everything QMP does; writing
>>> a QMP shell that makes QMP easy to interface with is a better solution
>>> for removing redundancy and complexity.
>>>
>>> - I suspect that the target audience for users of naked QEMU are:
>>>   - QEMU developers
>>>   - Upper-layer developers (RHV, oVirt, KubeVirt, libvirt, kata, et al)
>>> researching, testing, and debugging integration.
>>>   - Devops professionals testing, implementing and debugging
>>>     configuration & infrastructure
>>>   - Security/infosec researchers
>>>   - Embedded platform developers
>>>   - Academic researchers
>>>
>>>
>>>
>>> So please correct me if I am off the mark;
>>>
>>> Design Goals:
>>>   - The removal of HMP
>>>   - An easy-to-use interface that remains reasonably "close" to the
>>> machine API such that it provides a smooth transition to scripting QEMU.
>>>   - Integration with our GTK interface for discoverability and convenience
>>>
>>> Syntax:
>>>   - TBD? Do we agree that the current syntax in qmp-shell is "bad" and
>>> should be replaced? If yes, what should it look like?
>>
>> I believe it should be a python shell with added commands.
>>
>> Simple things should be simple.
>>   e.g. adding a disk from a local file should be trivial.
>>
>> Complex things can be complex - but it would be better if they were
>> simple.
>>
>>   It's OK if the worst case of a blockdev is a bit hairy, but
>>   watch out for cases where the hairyness creeps in unnecessarily.
> 
> Designing interfaces to complex machinery is hard.  Experience tells
> that we do okay when we focus on the building blocks first.  That's
> -blockdev.  When we start with trying to make simple things simple, we
> end in swamps.  That's -drive.
> 
> Focus on building blocks is of course no excuse for unnecessary
> hairiness.
> 
> It's also no reason not to build more convenient things on top of the
> building blocks.  I doubt they should go into QMP, though.
> 
>> If the user screwsup, it should give an error that prompts the user
>> to the parameter they got wrong.
>>
>> Output from commands should normally be pretty formatted (with an option
>> to display raw json for those needing it).
>>   e.g. that 'query-version' should give either just the package
>>   version (as info version currently does) or:
>>       4.2.50  Package: v4.2.0-1188-gd95a3885a9
>>
>> We shouldn't lose any HMP commands that some people find useful
>>   Ditching HMP isn't an option until we've got almost all of it
>>   covered.
> 
> In particular, we currently use HMP for debugging and monitoring
> purposes, where we don't need or want QMP's rigor, neither its rigorous
> interface stability, nor its structured I/O.  We want the "whipuptitude"
> we get from monitor_printf().  This is actually a point David has made
> several times.
> 

Yes, the "whipupitude" is something I am keen on preserving -- I just
want that whipupitude to be based on a schema.

Can we accomplish this with qmp-shell plugins that use special QMP
interfaces? I think so.

I'm imagining a special feature flag for "experimental" interfaces in
QMP that aren't thought through enough to become real interfaces that
these sugar commands -- implemented primarily in the shell - use.

They might do some bad things: they're synchronous, they might return a
bit too much data, they might return too much data. But it's only for
debug use, and we declare the API unstable/fluid, so we don't care.

Maybe this is a fool's errand, though, and we SHOULD just keep HMP.
Maybe we just need to QAPI-fy our HMP shell so that we can document it
better, and expand QAPI power to describe the format of HMP commands.

The core issue I take with HMP is that it's underdocumented, tends to
rot, and rarely keeps up with configuration idiom changes in QEMU -- it
*feels* like a legacy interface, not an up-to-date debugging interface.

However we fix this is actually not personally important to me.


> To have a qmp-shell replace HMP, I think it needs to be able to
> 
> * Go beyond 1:1
> 
>   We tried a 1:1 mapping between HMP and QMP commands, and it didn't
>   work out.  HMP's replacement should let us build convenient commands
>   from QMP building blocks.
> 
>   We tried a 1:1 mapping between HMP and QMP command arguments, guided
>   by @args_type.  Worked out for simple cases, but was too constricting.
> 
> * Preserve "whipuptitude" [David]
> 
>   I figure that means allowing some in QMP.  Without compromising its
>   core mission, of course.
> 
> * As discoverable as HMP is now [Kevin]
> 
> * Help, completion and such at least on par with what HMP provides now
> 
> Highly desirable:
> 
> * Support transitioning to the machine interface [John]
> 
>   Let humans start playing with the human interface, and when they feel
>   the need to automate, help them transition to QMP.
> 
> Back to John's question on qmp-shell syntax, which hasn't been answered
> so far.
> 
> JSON is a data-interchange format.  It doesn't try to be a configuration
> format or programming language syntax for human use.  It gets pressed
> into these roles with entirely predictable poor results.
> 

More or less; but it's still pretty decent as a format if you're editing
it in an IDE that can assist you in doing so.

No editor I am aware of at present is capable of editing JSON or YAML
against a schema, though: the prevailing paradigm appears to be:

- Write file in editor
- Run some validator command
- Deploy and pray

From what I can tell, this is how it works in the cloud world, too.

> Pain points of JSON include having to count parenthesises and having to
> quote so bloody much.  Additional QMP pain points include long names and
> excessive nesting.
> 
> For the configuration format role, more usable alternatives exist.  YAML
> is a popular one.
> 

Yes, but doesn't solve our parsing issue for interactive shells.

> qmp-shell is a REPL.  It needs a REPL-friendly syntax.  I doubt YAML is
> or even tries to be REPL-friendly.  I'd love to be wrong; the first rule
> of language design is "don't".
> 

Yes.

> Other language suggestions?
> 
> On making JSON suck less in this role:
> 
> LISP REPLs demonstrate that computers can assist effectively with
> counting parenthesises, and with completing long names.
> 
> We could make quoting optional for sufficiently nice object member
> names.  QAPI naming rules ensure niceness, actually.
> 
> We could make quoting optional for certain string literals.  Simple
> enough for literals that can only be a string, like abc.  For literals
> that could be something else like 123 or true, omitting quotes creates
> ambiguity.  When the schema accepts only one of the possible types, the
> ambiguity goes away.  Complexity stays, however.
> 
> Excessive nesting should ideally be attacked in QMP itself, but backward
> compatibility makes that hard.
> 

I wish I had a good idea on how to make a QMP wrapper that works in a
REPL that didn't involve copy/pasting JSON. I guess it's why so many
people *do* just cat data into the socket.


