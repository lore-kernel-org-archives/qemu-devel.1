Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C86C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:18:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A8FF20725
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 15:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QYvXh9Qy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8FF20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtunZ-0002Jb-Oa
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 11:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jtuiE-0003iS-Cj
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:13:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27032
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jtui9-0003Ps-0z
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 11:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594393991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=A12V1Jo9J+lOYqrm4mLVr73HLWGHLoMWU4jlqFTULPs=;
 b=QYvXh9QybhVBhV3cCuwTQVyIybzRYAed444i35S2KlLgyYH+g08NRMij60LXobNRmKeLDQ
 dxxnnV0XIuxzAE7AcvxQBCbieLw//aAmm6dFnlM3G+TpA1h1iZ86YK+Ff1XFsFVYv7D1Ma
 8g7Ca2GdrgaMg1g//ejKOkKuyx5JxzQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-ZeTgnOdvPlqJDWjOMuIY5g-1; Fri, 10 Jul 2020 11:13:08 -0400
X-MC-Unique: ZeTgnOdvPlqJDWjOMuIY5g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2026C100979E;
 Fri, 10 Jul 2020 15:13:07 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-127.ams2.redhat.com
 [10.36.113.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E3CBB1A7D8;
 Fri, 10 Jul 2020 15:13:05 +0000 (UTC)
Subject: Re: [PULL v2 00/52] Misc patches for QEMU 5.1 soft freeze
To: Claudio Fontana <cfontana@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200708172542.25012-1-pbonzini@redhat.com>
 <CAFEAcA8b6sn8fXOKwqOF6MvsKT5oKqS+4jjYDPAPvnXmVimLiQ@mail.gmail.com>
 <9631042d-00e4-2a2e-292b-66ca1b590120@suse.de>
 <CAFEAcA-UbHpj_xSbqjTsaURt8yPZjuYOmd3pe97vg_G7--17Cw@mail.gmail.com>
 <e78820bb-af5f-c2a0-7727-1a0caedfa584@suse.de>
 <CAFEAcA-raDJ2pSUG-OYHcJi_LnQwxMHvcyjsD7+=WxGYcrSz3w@mail.gmail.com>
 <a8113ed1-c508-0502-4f88-77f875d1a739@redhat.com>
 <40f4c566-8a5b-c27e-22a7-2a112a0cd77d@suse.de>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <c6e3336f-38b8-a8fa-4862-58e6f094711d@redhat.com>
Date: Fri, 10 Jul 2020 17:13:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <40f4c566-8a5b-c27e-22a7-2a112a0cd77d@suse.de>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 22:08:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10.07.20 16:44, Claudio Fontana wrote:
> On 7/10/20 3:11 PM, Philippe Mathieu-Daudé wrote:
>> On 7/10/20 2:55 PM, Peter Maydell wrote:
>>> On Fri, 10 Jul 2020 at 13:52, Claudio Fontana <cfontana@suse.de> wrote:
>>>> If you can access it,
>>>>
>>>> https://cirrus-ci.com/task/5537514263937024?command=main#L2039
>>>>
>>>> the thing is treated here as a warning, which is in the middle of a large amount of other warnings.
>>>>
>>>> private/var/folders/3y/l0z1x3693dl_8n0qybp4dqwh0000gn/T/cirrus-ci-build/ui/vnc-auth-sasl.c:648:29: warning: 'sasl_errdetail' is deprecated: first deprecated in macOS 10.11 [-Wdeprecated-declarations]
>>>>                             sasl_errdetail(vs->sasl.conn));
>>>>
>>>> /* ... lots of similar warnings */
>>>>
>>>> private/var/folders/3y/l0z1x3693dl_8n0qybp4dqwh0000gn/T/cirrus-ci-build/ui/cocoa.m:1478:9: warning: implicit declaration of function 'cpu_throttle_set' is invalid in C99 [-Wimplicit-function-declaration]
>>>>         cpu_throttle_set(throttle_pct);
>>>>         ^
>>>>
>>>>
>>>> Apparently the cirrus-ci I am using is not treating this as an error, while what you are using is..
>>>
>>> Ah, I see. Yeah, configure by default doesn't enable -Werror for OSX.
>>> My build tree has
>>>  '--extra-cflags=-fdiagnostics-color=never -Werror
>>> -Wno-error=deprecated-declarations'
>>
>> TIL this is different on OSX...
>>
>>>
>>> (of which the last two are relevant here). We should probably
>>> make configure use -Werror on OSX now with the same logic as Linux,
>>> I've been using it that way for ages without issues.
>>
>> Yes please!
>>
> 
> Speaking of MacOS and CI, commit 57ee95ed4ee7b4c039ec5f0705c45734c56706bc
> 
> Author: Max Reitz <mreitz@redhat.com>
> Date:   Thu Jun 25 14:55:30 2020 +0200
> 
>     iotests: Make _filter_img_create more active
> 
> broke cirrus-ci completely for me due to missing "readarray" builtin.
> 
> Maybe it is bash vs zsh?

Possible, but the iotests depend on bash.  All the iotests shell source
files explicitly reference bash in their shebang line, and so far we’ve
always assumed that they are thus going to be run by bash.

I suppose it’s well possible we’ve been lucky so far and all bash-isms
we used were supported by zsh as well.  But why does cirrus-ci run them
via zsh if the shebang line explicitly launches “bash”?

Max


