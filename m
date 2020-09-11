Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777C7C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 10:27:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2128220758
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 10:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6upewsy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2128220758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGgGv-0004Xm-4P
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 06:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kGgEb-00027j-Ga
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 06:24:49 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:43329)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kGgEZ-0007eL-Cx
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 06:24:49 -0400
Received: by mail-ed1-x544.google.com with SMTP id n13so9345770edo.10
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 03:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:subject:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=X6l+NkDdXH+iDMvkrjX+6Tq801e/RPPfologoBjLcM4=;
 b=J6upewsyAIPpfXOKuQbFpIHTo8PpRwrg1/Xj5apngK7bU8ZWEAUqVJ6gHM3PAWvkbL
 l44F5VJo8+DvH9z5sMU4CU3kn8HfCjIn434HPPHZCbWV/5uvTenP/NuBBXyIF78FxvMZ
 JsnjzktjCVAI4ZJwZ+2udKFFfT8sCLarL1HB1gqcJdvtjYgWDq39N0fRmUdDHCIx7HOn
 CL21baC0wxG1d2WA+XFtTbcG7SUno/dqOjdiiR9q7L1urF1vWe/w7ABGE8zwXMAzVdht
 xfq0kBJuq98ybyAv+4BLaljX3QPEOXDLKtDO4sjmPtzxz6rKgiX935meAZPbBKxkxdGk
 12Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:subject:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=X6l+NkDdXH+iDMvkrjX+6Tq801e/RPPfologoBjLcM4=;
 b=FFwEhnhYjB5IiW7vfFr0Lrmk2Zhij3oTgu1lC29ejDqkUO/v28R6pVukgfD9G1GgBP
 dH3siwXYyiPwNryNUnT4XjEOoYB8jIfbjxPv6B8sBgMyPoxZxU/JOhX8WtaTZn/APXFB
 cFGbt8xSpH/6us4Lzqyh4lVa5SoV32wWnuBlU0FsdNcD/f5PQiosr4UIGRovlNkhHUlk
 YJBXX9VM4oUmUNhtF1NAUaFVCuL80SNMqafJXp8jkF1jUeEgTJ0FYguIVvdJwHB9Jw9h
 ilXvkod8QfuCK9FcDsgDsSBgRi6/+AN5RvfFxN/y2sIhrv4yHrnwRi3e0+fjGvbtvaT/
 vlWg==
X-Gm-Message-State: AOAM531uhSgtt4jIO64MQ5YshOaicU6f4kkQbfpeZi81OKMb/hfPgB01
 kqa7SwH6HRpKEAr9ah2cmfg=
X-Google-Smtp-Source: ABdhPJy5CVOm6pGqlnTOP5gl4NV7gPDDlr0YGln/Vfnimb9+MCGbAhYGvUL8qgVim/MDnsvNz33h3w==
X-Received: by 2002:aa7:da89:: with SMTP id q9mr1193290eds.111.1599819885234; 
 Fri, 11 Sep 2020 03:24:45 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:6689:90a2:a29f:8336?
 ([2001:b07:6468:f312:6689:90a2:a29f:8336])
 by smtp.googlemail.com with ESMTPSA id w14sm1294511ejn.36.2020.09.11.03.24.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 03:24:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] PoC: Rust binding for QAPI (qemu-ga only, for now)
To: Marc-Andre Lureau <marcandre.lureau@redhat.com>
References: <20200910174850.716104-1-marcandre.lureau@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
 uUHgL9dKIfvpm+rNXRn9wAwGjk0X/A==
Message-ID: <eeead7ec-ebde-637d-de06-31c9b343b3b8@redhat.com>
Date: Fri, 11 Sep 2020 12:24:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200910174850.716104-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-ed1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-3.576,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "P. Berrange, Daniel" <berrange@redhat.com>,
 Sergio Lopez Pascual <slp@redhat.com>, "Hajnoczi, Stefan" <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, "Armbruster, Markus" <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On Thu, Sep 10, 2020 at 7:49 PM <marcandre.lureau@redhat.com> wrote:
> The usage is relatively simple:
>
> - from_qemu_none(ptr: *const sys::P) -> T
>   Return a Rust type T for a const ffi pointer P.
>
> - from_qemu_full(ptr: *mut sys::P) -> T
>   Return a Rust type T for a ffi pointer P, taking ownership.
>
> - T::to_qemu_none() -> Stash<P>
>   Returns a borrowed ffi pointer P (using a Stash to destroy "glue"
>   storage data, if any).
>
> - T::to_qemu_full() -> P
>   Returns a ffi pointer P. (P resources are leaked/passed to C/ffi)

I know these come from glib-rs, but still the names are awful. :)

What about:

- an unsafe variant of From/Into for from_qemu_full:

    trait UnsafeFrom<T> {
        unsafe fn unsafe_from(_: T) -> Self;
    }
    trait UnsafeInto<T> {
        unsafe fn unsafe_into(self) -> T;
    }
    impl <T, U> UnsafeInto<U> for T where U: UnsafeFrom<T> {
        unsafe fn unsafe_into(self) -> U { U::unsafe_from(self) }
    }

Example:

    impl UnsafeFrom<*mut c_char> for String {
        unsafe fn unsafe_from(ptr: *mut c_char) -> Self {
            let res = Self::new_from_foreign(ptr);
            libc::free(ptr as *mut c_void);
            res
        }
    }

- likewise, a generic IntoRaw trait for to_qemu_full:

    trait IntoRaw<T> {
        fn into_raw(self) -> *mut T;
    }

Example:

    impl IntoRaw<c_char> for String {
        fn into_raw(self) -> *mut c_char {
            unsafe {
                libc::strndup(self.as_ptr() as *const c_char,
                              self.len() as size_t)
            }
        }
    }

- and a simpler/nicer version of Stash, from_qemu_none and to_qemu_none like this:

    pub struct BorrowedPointer<'a, P, T: 'a> {
        pub native: *const P,
        pub storage: T,
        _marker: PhantomData<&'a T>,
    }

    impl<'a, P: Copy, T: 'a> BorrowedPointer<'a, P, T> {
        fn new(native: *const P, storage: T) -> Self {
            BorrowedPointer {
                native,
                storage,
                _marker: PhantomData
            }
        }

        fn as_ptr(&self) -> *const P {
            self.native
        }
    }

    trait ForeignConvertible<'a> {
        type Native: Copy;
        type Storage: 'a;
         unsafe fn new_from_foreign(p: *const Self::Native) -> Self;
        fn as_foreign(&'a self) -> BorrowedPointer<'a, Self::Native, Self::Storage>;
    }

Implemented like this:

    impl ForeignConvertible<'_> for String {
        type Native = c_char;
        type Storage = CString;

        unsafe fn new_from_foreign(p: *const c_char) -> Self {
            let cstr = CStr::from_ptr(p);
            String::from_utf8_lossy(cstr.to_bytes()).into_owned()
        }
        fn as_foreign(&self) -> BorrowedPointer<c_char, CString> {
            let tmp = CString::new(&self[..]).unwrap();
            BorrowedPointer::new(tmp.as_ptr(), tmp)
        }
    }

and possibly:

    impl<'a, P: Copy, T: 'a> BorrowedMutPointer<'a, P, T> {
        fn new(native: *mut P, storage: T) -> Self {
            BorrowedMutPointer {
                native,
                storage,
                _marker: PhantomData
            }
        }

        fn as_ptr(&self) -> *const P {
            self.native
        }

        fn as_mut_ptr(&mut self) -> *mut P {
            self.native
        }
    }

    trait ForeignMutConvertible<'a>: ForeignConvertible<'a> {
      fn as_foreign_mut(&self) -> BorrowedMutPointer<Self::Native, Self::Storage>;
    }

I placed the source code for the above at https://github.com/bonzini/rust-ptr

I'll look later at the rest of the code.  It's quite big. :)

Paolo

