Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE95C10F14
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 18:56:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC15C20673
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 18:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t9iASMqm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC15C20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFjnH-0004Qm-Sy
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 14:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51367)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iFjmL-0003cQ-KS
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 14:55:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iFjmK-0000KQ-3n
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 14:55:13 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36735)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iFjmJ-0000Jg-SK
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 14:55:12 -0400
Received: by mail-wr1-x442.google.com with SMTP id y19so238874wrd.3
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 11:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Vki01ml0ggkTvVCFhXIK0o2v4xlEtfm8fmkmHfDium8=;
 b=t9iASMqmpkNxuYMyTKm9w3m3zRbsXWbQzeOIpIxhljKAWMxkXMIZjL3Mi5sQXoM67O
 HzYSsqv0Pc7ERXFYL+Td73kRy48WzIi8PSvZ+EO3HR2m3S3jO7mmjIWE1vj3hDjqGbXP
 Gyseg+1T8H+ANbp0IC9I+kYfNlnGmP5l7p5TGZsXDpHrgBewJnD0zZNWVWSVGqYyBcy9
 x+IioGdrY1kzOaaZs3ey3i8H+WI3U95/Se07M0r+aLF/525oy0c5+Y4MJgSt6frVcFJv
 KV2ufMrV7wLrf0QbFUBDOkgx4MR2rjDrb/YeoXoN4sQyzQdzv0APY3j5Uog62LmzISJ3
 xidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Vki01ml0ggkTvVCFhXIK0o2v4xlEtfm8fmkmHfDium8=;
 b=WWl/uaO8afYjZnKF1Kcl6DCUolW49GP/Bvd4CmffluNHKk2X/3eEKhJxIYkCNGJRA1
 YvEwZbG7wmY7MiXkBaWQ4Zo2GpuhA0dRuR7p0RTOtMp5tDgQ00DvaTUxc0oI/jI7Xix5
 uNf194O0JXcxKK8asjCIV69SIBSsAU+hGgaD9YgLonNvfs76nNCnVE8DjNlIRa4QCR2/
 nfRZoXxiNHGGIPWKydZxg66cXm8S7jiJWeAH+t+2/M0pvYhD7o3T26Jlw3DGvDlGsWPj
 BQlaTrVqt3RJJoC4hhrdQ8CgQfgmTuBkBF4zESRBSwDupvOFzra40tr5+dqWQl3Brdvy
 bt8Q==
X-Gm-Message-State: APjAAAXlVfi2EiUjR++jTHLsZ1SbZ4nhQIWiw6+z89VYVLmIOV7ytu5z
 PjhJu0qBNnCyiGLFvpKGUGu8xQ==
X-Google-Smtp-Source: APXvYqxZuwwPsWmqYXB/2bGZzpmiDSwZ1EKHupQeurn8IOWnpt3fwJOh7jiq0K68572+xuMjQbB3+w==
X-Received: by 2002:adf:e812:: with SMTP id o18mr3832231wrm.398.1570042510511; 
 Wed, 02 Oct 2019 11:55:10 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o22sm335230wra.96.2019.10.02.11.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2019 11:55:09 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 63EE01FF87;
 Wed,  2 Oct 2019 19:55:08 +0100 (BST)
References: <20190830121903.17585-1-vandersonmr2@gmail.com>
 <20190830121903.17585-2-vandersonmr2@gmail.com>
 <20190902100755.GG9069@stefanha-x1.localdomain>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [Qemu-devel] [PATCH v2 1/2] accel/tcg: adding integration with
 linux perf
In-reply-to: <20190902100755.GG9069@stefanha-x1.localdomain>
Date: Wed, 02 Oct 2019 19:55:08 +0100
Message-ID: <87tv8rj7ub.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 vandersonmr <vandersonmr2@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Fri, Aug 30, 2019 at 09:19:02AM -0300, vandersonmr wrote:
>> This commit adds support to Linux Perf in order
>> to be able to analyze qemu jitted code and
>> also to able to see the TBs PC in it.
>>
>> When using "-perf" qemu creates a jitdump file in
>> the current working directory. The file format
>> specification can be found in:
>> https://github.com/torvalds/linux/blob/master/tools/perf/Documentation/j=
itdump-specification.tx
>
> Oops, the link is broken: .txt
>
>> +struct jr_code_close {
>> +    struct jr_prefix p;
>> +};
>
> Unused?
>
>> +
>> +struct jr_code_move {
>
> Unused?
>
>> +static uint32_t get_e_machine(void)
>> +{
>> +    uint32_t e_machine =3D EM_NONE;
>> +    Elf64_Ehdr elf_header;
>> +    FILE *exe =3D fopen("/proc/self/exe", "r");
>> +
>> +    if (exe =3D=3D NULL) {
>> +        return e_machine;
>> +    }
>> +
>> +    if (fread(&elf_header, sizeof(Elf64_Ehdr), 1, exe) !=3D 1) {
>
> What if this is a 32-bit binary because QEMU was built for a 32-bit
> host?
>
>> +        goto end;
>> +    }
>> +
>> +    e_machine =3D elf_header.e_machine;
>> +
>> +end:
>> +    fclose(exe);
>> +    return e_machine;
>> +}
>> +
>> +void start_jitdump_file(void)
>> +{
>> +    gchar *dumpfile_name =3D g_strdup_printf("./jit-%d.dump", getpid());
>
> You can now use g_autofree:
>
>   g_autofree gchar *dumpfile_name =3D g_strdup_printf(...);
>
> and then the explicit g_free() isn't necessary anymore (and the memory
> leak in the mmap error case is also solved).
>
>> +void append_load_in_jitdump_file(TranslationBlock *tb)
>> +{
>> +    gchar *func_name =3D g_strdup_printf("TB virt:0x"TARGET_FMT_lx, tb-=
>pc);
>> +
>> +    struct jr_code_load load_event;
>> +    load_event.p.id =3D JIT_CODE_LOAD;
>> +    load_event.p.total_size =3D
>> +        sizeof(struct jr_code_load) + strlen(func_name) + 1 + tb->tc.si=
ze;
>> +    load_event.p.timestamp =3D get_timestamp();
>> +    load_event.pid =3D getpid();
>> +    load_event.tid =3D syscall(SYS_gettid);
>> +    load_event.vma =3D tb->pc;
>> +    load_event.code_addr =3D (uint64_t) tb->tc.ptr;
>> +    load_event.code_size =3D tb->tc.size;
>> +    load_event.code_index =3D tb->pc;
>> +
>> +    fwrite(&load_event, sizeof(struct jr_code_load), 1, dumpfile);
>> +    fwrite(func_name, strlen(func_name) + 1, 1, dumpfile);
>> +    fwrite(tb->tc.ptr, tb->tc.size, 1, dumpfile);
>> +
>> +    g_free(func_name);
>> +    fflush(dumpfile);
>> +}
>
> I didn't see a reply to my question on the previous patch series:
>
>   "append_load_in_jitdump_file() calls fwrite() multiple times.  What
>   guarantees they will not be interleaved when multiple threads call
>   this function?"

Ahh that was exactly the problem I was debugging. Fixed with a lock now.

> Does TCG ever throw away TBs and is it necessary to record this in the
> file so perf knows about it?

Yes - I suspect that's what the currently unused headers are for.

--
Alex Benn=C3=A9e

